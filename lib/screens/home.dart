import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return null;
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
    );
  }

  Widget getListView(BuildContext context) {

    return ListView.builder(itemBuilder: (context, index){
      return ListTile(
        leading: getPriorityIcon(index),
        title: Text("Dummy title"),
        trailing: Icon(Icons.delete),
        onTap: (){
          //todo
        },
      );
    });
  }

  getPriorityIcon(int index) {}
}
