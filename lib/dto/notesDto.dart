import 'package:notes_app/dto/connector.dart';
import 'package:notes_app/dao/notes.dart';

class NotesDto{
  static Future<List<Notes>> allNotes() async {
    var db = await Connector.getDb();
    List<Map<String,dynamic>> maps = await db!.rawQuery("select * from notes");
    return List.generate(maps.length, (index) {
      var  column=maps[index];
      return Notes(column["note_id"], column["lesson_name"], column["note1"], column["note2"]);
    });
  }
  static Future<void> addNote(String lessonName,int note1,int note2) async {
    var db = await Connector.getDb();
    Map<String,dynamic> info = <String,dynamic>{};
    info["lesson_name"]=lessonName;
    info["note1"]=note1;
    info["note2"]=note2;
    db!.insert("notes", info);
  }
  static Future<void> updateNote(int noteId, String lessonName,int note1,int note2) async {
    var db = await Connector.getDb();
    Map<String,dynamic> info = <String,dynamic>{};
    info["lesson_name"]=lessonName;
    info["note1"]=note1;
    info["note2"]=note2;
    db!.update("notes", info,where: "note_id=?",whereArgs: [noteId]);
  }
 static  Future<void> deleteNote(int noteId) async {
    var db = await Connector.getDb();
    db!.delete("notes",where: "note_id=?",whereArgs: [noteId]);
  }
}