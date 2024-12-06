import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/todo.dart';

class DataManager {
  static const String _todoListKey = 'todo_list';

  static Future<List<ToDo>> getTodoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList(_todoListKey);

    if(jsonStringList == null) {
      return [];
    }

    return jsonStringList.map((jsonString) => ToDo.fromJson(json.decode(jsonString))).toList();
  }

  static Future<void> saveTodoList(List<ToDo> todoList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonStringList = todoList.map((todo) => json.encode(todo.toJson())).toList();
    prefs.setStringList(_todoListKey, jsonStringList);
  }

}