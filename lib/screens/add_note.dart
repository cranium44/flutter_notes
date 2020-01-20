import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_notes/utils/db_utils.dart';
import 'package:flutter_notes/models/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class AddNote extends StatefulWidget {
  final String title;
  final Note note;

  AddNote(this.note, this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddNoteUI(note, title);
  }
}

class AddNoteUI extends State<AddNote> {
  var _priorities = ["Low", "High"];
  var _priority = "";
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();

  DBHelper _dbHelper = DBHelper();

  String title;
  Note note;

  AddNoteUI(this.note, this.title);

  @override
  void initState() {
    _priority = getPriorityAsString(note.priority);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(
          padding: EdgeInsets.all(5.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5.0),
              child: DropdownButton(
                items: _priorities.map((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (String value) {
                  setState(() {});
                },
                value: _priority,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    labelText: "Title",
                    hintText: "Title of note",
                    errorStyle: TextStyle(color: Colors.red, fontSize: 12.0)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    labelText: "Contentes",
                    hintText: "Contents of note",
                    errorStyle: TextStyle(color: Colors.red, fontSize: 12.0)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {},
                      child: Icon(
                        Icons.save,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(width: 20,),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {},
                      child: Icon(
                        Icons.cancel,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String getPriorityAsString(int priority){
    switch(priority){
      case 1: return _priorities[1];
      case 2: return _priorities[0];
      default: return _priorities[0];
    }
  }
  
  int getStringPriorityAsInt(String str){
    switch(str){
      case "Low": return 2;
      case "High": return 1;
      default: return 2;
    }
  }
}
