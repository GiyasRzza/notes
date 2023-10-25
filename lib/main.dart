import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notes_app/addNotes.dart';
import 'package:notes_app/dto/notesDto.dart';
import 'package:notes_app/notesDetails.dart';

import 'dao/notes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Notes>> allNotes() async {
    return NotesDto.allNotes();
  }
  Future<bool> closeApp() async {
      exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), onPressed: () { closeApp(); },
        ),
        backgroundColor: Colors.blueAccent,
        title:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("Average Note",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,color: Colors.white

            ),
            ),
            WillPopScope(
              onWillPop: () => closeApp(),
              child: FutureBuilder(
                  future: allNotes(),
                builder: (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
                        if(snapshot.hasData){
                          var notesList = snapshot.data;
                         double avarage=0.0;
                         if(notesList!.isNotEmpty){
                           double toplam=0.0;
                           for(var n in notesList){
                             toplam=toplam+(n.note1+n.note2)/2;
                           }
                           avarage = toplam/notesList.length;
                         }
                          return Text("Average : $avarage",style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),);

                        }
                        else{
                          return  const Text("Average : 0",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),);
                        }
                },
              ),
            )
          ],
        ),

      ),
      body:FutureBuilder<List<Notes>>(
        future: allNotes(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var notesList = snapshot.data;
            return ListView.builder(
              itemCount: notesList?.length,
                itemBuilder: (context, index) {
                  var note = notesList?[index];
                  return InkWell(
                    onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  NotesDetails(notes: note,),));
                    },
                    child: Card(
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(note!.lessonName,style: const TextStyle(
                              fontWeight: FontWeight.bold
                             ),
                                ),
                            Text(note.note1.toString(),
                            ),
                            Text(note.note2.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
            );
          }
          else{
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNotes(),));
        },
        tooltip: "Save",
        child: const Icon(Icons.add),
      ),
    );
  }
}
