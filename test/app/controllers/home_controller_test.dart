import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list_local/app/controllers/home_controller.dart';

main() {
  final textController = TextEditingController();
  final controller = HomeController(titleController: textController);

  test('Adiciona uma nova tarefa', () {
    textController.text = 'Patricio JavaScript';
    controller.addTask();
    expect(controller.listTodo.isNotEmpty, true);
  });
  test('Remove um item da lista', () {
    controller.removeTodo(0);
    expect(controller.lastRemoved.title, 'Patricio JavaScript');
  });
}
