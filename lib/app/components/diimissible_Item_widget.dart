import 'package:flutter/material.dart';
import 'package:todo_list_local/app/controllers/home_controller.dart';
import 'package:todo_list_local/app/models/todo_model.dart';

// ignore: must_be_immutable
class DimissibleItem extends StatefulWidget {
  int index;
  TodoModel task;
  HomeController controller;
  DimissibleItem({Key key, this.index, this.task, this.controller})
      : super(key: key);
  @override
  _DimissibleItemState createState() => _DimissibleItemState();
}

class _DimissibleItemState extends State<DimissibleItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(
          DateTime.now().millisecondsSinceEpoch.toString(),
        ),
        background: Container(
          color: Colors.red,
          child: Align(
            child: Icon(Icons.delete, color: Colors.white),
            alignment: Alignment(-0.98, 0.0),
          ),
        ),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          widget.controller.removeTodo(widget.index);
          final snackbar = SnackBar(
            content: Text("O item \"${widget.task.title}\" foi removido"),
            duration: Duration(seconds: 2),
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: () {
                widget.controller.addTask(position: widget.index);
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        },
        child: CheckboxListTile(
          secondary: CircleAvatar(
            child: Icon((widget.task.done) ? Icons.done : Icons.error),
          ),
          value: widget.task.done,
          onChanged: (value) {
            setState(() {
              widget.task.done = value;
            });
          },
          title: Text(widget.task.title),
        ));
  }
}
