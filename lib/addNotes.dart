import 'package:flutter/material.dart';
import 'package:notes_app/dto/notesDto.dart';
import 'package:notes_app/main.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  var tfLesson = TextEditingController();
  var tfNote1 = TextEditingController();
  var tfNote2 = TextEditingController();
  Future<void> save(String lessonName,int note1,int note2)async {
      NotesDto.addNote(lessonName, note1, note2);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp(),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Add Note"),
      ),
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0,right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              TextField(
                keyboardType: TextInputType.name,
                controller: tfLesson,
                decoration: const InputDecoration(
                  label: Text("Lesson Name"),

                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: tfNote1,
                decoration: const InputDecoration(
                  label: Text("First Note"),

                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: tfNote2,
                decoration: const InputDecoration(
                  label: Text("Second Note"),
                ),
              )
            ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () {
            save(tfLesson.text, int.parse(tfNote1.text), int.parse(tfNote2.text));
        },
        tooltip: "Add Note",
        label: const Text("Save"),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
