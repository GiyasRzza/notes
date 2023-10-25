import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class Connector{

  static Future<Database?> getDb() async {
    String dbPath = join(await getDatabasesPath(), 'notes.sqlite');
    File dbFile = File(dbPath);
    if (!dbFile.existsSync()) {
      ByteData data = await rootBundle.load("db/notes.sqlite");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await dbFile.writeAsBytes(bytes, flush: true);
      print("Database copied");
    }
    return openDatabase(dbPath);
  }

  }