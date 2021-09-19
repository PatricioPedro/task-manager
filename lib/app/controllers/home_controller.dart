import 'package:flutter/material.dart';
import 'package:todo_list_local/app/models/todo_model.dart';

class HomeController {
  final TextEditingController titleController;
  final List<TodoModel> listTodo = [];
  TodoModel lastRemoved;
  int indexOfLastRemoved;
  final key = GlobalKey<FormState>();

  HomeController({this.titleController});

  // ignore: missing_return
  String validation(var value) {
    switch (value) {
      case "":
        return "Este campo nao pode ser vazio";
    }
  }

  void addTask({int position}) {
    if (position != null) {
      this.listTodo.insert(indexOfLastRemoved, lastRemoved);
      return;
    }
    Map<String, dynamic> newTask = Map();
    newTask['title'] = titleController.text;
    newTask['done'] = false;
    this.listTodo.add(TodoModel.fromJson(newTask));
    this.titleController.text = "";
  }

  void removeTodo(index) {
    lastRemoved = listTodo[index];
    indexOfLastRemoved = index;
    listTodo.removeAt(index);
  }

  Future<void> refresh() async {
    await Future.delayed(Duration(seconds: 1));
    this.listTodo.sort((a, b) {
      if (a.done && !b.done) return 1;
      if (!a.done && b.done) return -1;
      return 0;
    });
  }
}
