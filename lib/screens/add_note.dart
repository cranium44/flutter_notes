import 'package:flutter/material.dart';

class AddNote extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddNoteUI();
  }

}

class AddNoteUI extends State<AddNote>{

  var _priorities = ["Low", "High"];
  @override
  Widget build(BuildContext context) {
    return Material(child: Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[

        ],
      ),
    ),);
  }

}