import 'package:flutter/material.dart';
import 'package:flutter_notes/screens/add_note.dart';
import 'dart:async';
import 'package:flutter_notes/utils/db_utils.dart';
import 'package:flutter_notes/models/notes.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeSUI();
  }
}

class HomeSUI extends State<HomePage> {
  DBHelper dbHelper = DBHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if(noteList == null){
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getListView(context),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add new note",
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          addNewNote(context, "Add Note", Note('','', 2));
        },
      ),
    );
  }

  Widget getListView(BuildContext context) {
    return ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: getPriorityColor(noteList[index].priority),
                child: getPriorityIcon(noteList[index].priority),
              ),
              title: Text(noteList[index].title),
              subtitle: Text(noteList[index].date),
              trailing: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onTap: (){
                  delete(context, noteList[index]);
                },
              ),
              onTap: () {
                addNewNote(context, "Edit Note", noteList[index]);
              },
            ),
          );
        });
  }

  void addNewNote(BuildContext context, String title, Note note) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNote(note, title);
    }));
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;

      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;

      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  delete(BuildContext context, Note note) async {
    int res = await dbHelper.deleteNote(note.id);
    if (res != 0) {
      showSnackBar(context, "Note deleted Successfuly");
    }
    //update list
    updateListView();
  }

  showSnackBar(BuildContext context, String message) {
    final snackbar = SnackBar(
      content: Text(message),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  void updateListView() {
    final db = dbHelper.initializeDB();
    db.then((database){
      var list = dbHelper.getNoteList();
      list.then((noteList){
        this.noteList = noteList;
        this.count = noteList.length;
      });
    });
  }


}
