import 'package:flutter/material.dart';
import 'package:notes_app/dao/notes.dart';
import 'package:notes_app/dto/notesDto.dart';

import 'main.dart';

class NotesDetails extends StatefulWidget {
   Notes notes;
   NotesDetails({super.key, required this.notes});

  @override
  State<NotesDetails> createState() => _NotesDetailsState();
}

class _NotesDetailsState extends State<NotesDetails> {
  var tfLesson = TextEditingController();
  var tfNote1 = TextEditingController();
  var tfNote2 = TextEditingController();
  Future<void> delete(int noteId)async {
    NotesDto.deleteNote(noteId);
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const MyApp(),));
  }
  Future<void> update(int noteId)async {
    NotesDto.updateNote(noteId, tfLesson.text, int.parse(tfNote1.text), int.parse(tfNote1.text));
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const MyApp(),));
  }
  @override
  void initState() {
    super.initState();
    tfLesson.text=widget.notes.lessonName;
    tfNote1.text=widget.notes.note1.toString();
    tfNote2.text=widget.notes.note2.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Notes Details"),
        actions: [
          TextButton(
              onPressed: () {
                delete(widget.notes.noteId);
              },
              child: const Text("Delete",style: TextStyle(color: Colors.white),)
          ),
          TextButton(
              onPressed: () {
                update(widget.notes.noteId);
              },
              child: const Text("Update",style: TextStyle(color: Colors.white),)
          ),
        ],
      ),
      body: Center(
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
    );
  }
}
