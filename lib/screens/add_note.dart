import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddNoteUI();
  }
}

class AddNoteUI extends State<AddNote> {
  var _priorities = ["Low", "High"];
  var _priority = "";
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();

  @override
  void initState() {
    _priority = _priorities[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Note"),
        ),
        body: ListView(
          padding: EdgeInsets.all(5.0),
          children: <Widget>[
            DropdownButton(
              items: _priorities.map((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
              onChanged: (String value) {
                setState(() {});
              },
              value: _priority,
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

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
