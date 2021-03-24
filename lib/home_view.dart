import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/todo_app_page.dart';

import 'db_service.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DbService service = DbService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Uygulaması"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("todos").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView(
            children: snapshot.data.docs
                .map((data) => ListTile(
                      leading: data["status"] == false
                          ? Icon(Icons.do_not_disturb_on, color: Colors.red)
                          : Icon(Icons.done_outline_outlined,
                              color: Colors.green),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: data["status"] == false
                              ? Colors.transparent
                              : Colors.red,
                        ),
                        onPressed: () {
                          service.deleteTodo(data.id);
                        },
                      ),
                      title: Text(data["title"]),
                      subtitle: Text(data["subTitle"]),
                      onTap: () {
                        service.todoStatusUpdate(data.id, data["status"]);
                      },
                    ))
                .toList(),
            padding: EdgeInsets.only(bottom: 100),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addTodoPage();
        },
      ),
    );
  }

  void addTodoPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TodoAddPage()));
  }
}
