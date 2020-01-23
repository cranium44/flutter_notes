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
    _titleController.text = note.title;
    _contentController.text = note.contents;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (){
          goBackToPrevious();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: (){
              goBackToPrevious();
            },),
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
                    setState(() {
                      _priority = value;
                      note.priority = getStringPriorityAsInt(value);
                    });
                  },
                  value: getPriorityAsString(note.priority),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      labelText: "Title",
                      hintText: "Title of note",
                      errorStyle: TextStyle(color: Colors.red, fontSize: 12.0)),
                  onChanged: (String value){
                    setState(() {
                      note.title = _titleController.text;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: _contentController,
                  onChanged: (String value){
                    setState(() {
                      note.contents = _contentController.text;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      labelText: "Contents",
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
                        onPressed: () {
                          setState(() {
                            note.date = getDateAsString();
                            save();
                          });
                        },
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
                        onPressed: () {
                          clear();
                        },
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

  String getDateAsString(){
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  save() async{
    int result;

    goBackToPrevious();
    //check if update or insert
    if(note.id == null){
      result = await _dbHelper.insertNote(note);
    }else{
      result = await _dbHelper.updateNote(note);
    }

    //status of operation
    if(result != 0){
      showAlertDialog('Status', 'Saved Successfuly');
    }else{
      showAlertDialog('Status', 'Saved Successfuly');
    }

    //cleanup
    clear();
  }

  clear(){
    setState(() {
      _titleController.text = '';
      _contentController.text = '';
      _priority = getPriorityAsString(10);
    });
  }

  void showAlertDialog(String s, String t) {
    AlertDialog dialog = AlertDialog(title: Text(s),content: Text(t),);
    showDialog(context: context, builder: (_)=>dialog);
  }

  goBackToPrevious(){
    Navigator.pop(context, true);
  }

}
