import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/data/data_manager.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/screens/home_screen/widgets/home_app_bar.dart';
import 'package:to_do_app/screens/search_screen/widgets/search_box.dart';
import 'package:to_do_app/widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList;
  List<ToDo> foundToDo = [];
  final todoController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    DataManager.getTodoList().then((todoList) {
      setState(() {
        foundToDo = todoList;
      });
    });
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: const HomeAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBox(onFilter: runFilter),
            _buildCalendar(),
            const SizedBox(height: 10),
            const Text(
              "ToDo",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: green1,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 26, bottom: 20),
                  ),
                  for (ToDo item in foundToDo)
                    if (_selectedDate == item.date)
                      ToDoItem(
                        todo: item,
                        onToDoChange: handleToDoChange,
                        onDeleteItem: deleteToDoItem,
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = foundToDo
          .where((item) =>
              item.title!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundToDo = results;
    });
  }

  void handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    DataManager.saveTodoList(todosList);
  }

  void deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
    DataManager.saveTodoList(todosList);
  }

  EasyDateTimeLine _buildCalendar() {
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (date) {
        setState(() {
          _selectedDate = date;
        });
      },
    );
  }
}
