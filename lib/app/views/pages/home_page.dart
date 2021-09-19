import 'package:flutter/material.dart';
import 'package:todo_list_local/app/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final text = TextEditingController();
  HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = HomeController(titleController: text);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Form(
            key: controller.key,
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: text,
                  validator: (value) {
                    return controller.validation(value);
                  },
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Nova tarefa',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                )),
                ElevatedButton(
                  onPressed: () {
                    if (controller.key.currentState.validate()) {
                      setState(() {
                        controller.addTask();
                      });
                    }
                  },
                  child: Text('Adicionar'),
                )
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 1));
                setState(() {
                  controller.listTodo.sort((a, b) {
                    if (a.done && !b.done) return 1;
                    if (!a.done && b.done) return -1;
                    return 0;
                  });
                });
              },
              child: ListView.builder(
                  itemCount: controller.listTodo.length,
                  itemBuilder: (context, index) {
                    var task = controller.listTodo[index];
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
                          setState(() {
                            controller.removeTodo(index);
                            final snackbar = SnackBar(
                              content:
                                  Text("O item \"${task.title}\" foi removido"),
                              duration: Duration(seconds: 2),
                              action: SnackBarAction(
                                label: "Desfazer",
                                onPressed: () {
                                  setState(() {
                                    controller.addTask(position: index);
                                  });
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: CheckboxListTile(
                            secondary: CircleAvatar(
                              child:
                                  Icon((task.done) ? Icons.done : Icons.error),
                            ),
                            value: task.done,
                            onChanged: (value) {
                              setState(() {
                                task.done = value;
                              });
                            },
                            title: Text(task.title),
                          ),
                        ));
                  }),
            ),
          ),
        ],
      ),
    ));
  }
}
