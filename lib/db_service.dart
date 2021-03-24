import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/todo.dart';

class DbService {
  CollectionReference dbtodos = FirebaseFirestore.instance.collection("todos");

  Future<void> addTodo(Todo todo) {
    return dbtodos
        .add(
            {"title": todo.title, "subTitle": todo.subTitle, "status": false})
        .then((value) => true)
        .catchError((err) => false);
  }

  Future<void> todoStatusUpdate(String dataId,bool statu) {
    return dbtodos.doc(dataId).update(
      {
        "status":!statu
      }
    );
  }
  Future<void> deleteTodo(String dataId){
    return dbtodos.doc(dataId).delete().then((value) => true).catchError((onError)=>false);
  }
}
