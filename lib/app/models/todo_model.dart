import 'dart:convert';

class TodoModel {
  String title;
  bool done;

  TodoModel.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.done = json['done'];
  }
  String toJson(Map<String, dynamic> json) {
    return jsonEncode(json);
  }
}
