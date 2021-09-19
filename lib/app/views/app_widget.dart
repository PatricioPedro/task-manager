import 'package:flutter/material.dart';
import 'package:todo_list_local/app/views/pages/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todo List'),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        body: HomePage(),
      ),
    );
  }
}
