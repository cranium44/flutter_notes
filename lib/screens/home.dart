import 'package:flutter/material.dart';
import 'package:flutter_notes/screens/add_note.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeSUI();
  }
}

class HomeSUI extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
          addNewNote(context, "Add Note");
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
              leading: getPriorityIcon(index),
              title: Text("Dummy title"),
              subtitle: Text("Sweet ass subtitles $index"),
              trailing: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                addNewNote(context, "Edit Note");
              },
            ),
          );
        });
  }

  Widget getPriorityIcon(int index) {
    return null;
  }

  void addNewNote(BuildContext context, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNote(title);
    }));
  }
}
