
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_notes/models/notes.dart';

class DBHelper {
  static DBHelper _dbHelper;
  static Database _database;

  //table and column details
  String table_name = "note_table";
  String col_id = "id";
  String col_title = "title";
  String col_contents = "contents";
  String col_date = "date";
  String col_priority = "priority";

  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper.getInstance();
    }
    return _dbHelper;
  }

  DBHelper.getInstance();

  void _createDB(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $table_name( $col_id INTEGER PRIMARY KEY AUTOINCREMENT, $col_title TEXT, $col_contents TEXT, $col_date TEXT, $col_priority INTEGER)");
  }

  Future<Database> initializeDB() async {
    //get directory of both android and ios databases
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    //create or open db at path
    var noteDb = openDatabase(path, version: 1, onCreate: _createDB);
    return noteDb;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDB();
    }
    return _database;
  }

  //Database CRUD operations

  //Read the database
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    Database db = await this.database;
    var noteList = db.query(table_name, orderBy: '$col_priority ASC');
    return noteList;
  }

  //Insert note
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var res = db.insert(table_name, note.toMap());
    return res;
  }

  //Delete note
  Future<int> deleteNote(int id) async{
    Database db =  await this.database;
    return db.rawDelete("DELETE FROM $table_name WHERE $col_id = $id");
  }

  //Update note
  Future<int> updateNote(Note note) async{
    Database db = await this.database;
    return db.update(table_name, note.toMap(), where: '$col_id = ?', whereArgs: [note.id]);
  }
  
  //get object count from db
  Future<int> getNoteCount() async{
    Database db = await this.database;
    var x = await db.query(table_name);
    var res = Sqflite.firstIntValue(x);
    return res;
  }

  //convert notelist map to notes
  Future<List<Note>> getNoteList() async{
    var noteListMap = await getAllNotes();
    List<Note> noteList = List<Note>();
    int count = noteListMap.length;

    for(int i = 0; i<count; i++){
      noteList.add(Note.fromMapObject(noteListMap[i]));
    }

    return noteList;
  }
}
