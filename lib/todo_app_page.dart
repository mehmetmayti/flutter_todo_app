import 'package:flutter/material.dart';
import 'package:todo_app/db_service.dart';
import 'package:todo_app/todo.dart';

// ignore: must_be_immutable
class TodoAddPage extends StatelessWidget {
  DbService service = DbService();
  final _title = TextEditingController();
  final _subTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Ekleme Sayfası"),
      ),
      body: Container(
        width: 400,
        height: 300,
        //margin: EdgeInsets.all(50),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: _title,
              decoration: InputDecoration(
                hintText: "Todo Başlık",
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              autofocus: true,
              controller: _subTitle,
              decoration: InputDecoration(
                hintText: "Todo Açıklama Girin",
              ),
            ),
            SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: () {
                SnackBar mySnackbar;
                service.addTodo(Todo(_title.text, _subTitle.text));
                Navigator.of(context).pop();
              },
              child: Text(
                "Ekle",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
