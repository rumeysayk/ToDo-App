import 'package:flutter/material.dart';
import 'package:to_do_app/screens/search_screen/widgets/search_app_bar.dart';

import '../../constants/colors.dart';
import '../../data/data_manager.dart';
import '../../model/todo.dart';
import '../../widgets/todo_item.dart';
import 'widgets/search_box.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final todosList = ToDo.todoList;
  List<ToDo> foundToDo = [];
  String _selectedFilter = 'None';

  @override
  void initState() {
    DataManager.getTodoList().then((todoList) {
      setState(() {
        foundToDo = todoList;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBox(onFilter: runFilter),
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 26, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'All ToDos',
                          style: TextStyle(
                            color: green1,
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        PopupMenuButton<String>(
                          icon: const Icon(
                            Icons.filter_list_rounded,
                            color: green1,
                          ),
                          color: green4,
                          onSelected: _filterToDoList,
                          itemBuilder: (BuildContext context) {
                            return {
                              'None',
                              'Priority',
                              'Recent to Oldest',
                              'Oldest to Recent'
                            }.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(
                                  choice,
                                  style: const TextStyle(
                                    color: green2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        for (ToDo item in foundToDo)
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
          ],
        ),
      ),
    );
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
      foundToDo = todosList;
      _filterToDoList(_selectedFilter);
    });
    DataManager.saveTodoList(todosList);
  }

  void _filterToDoList(String filter) {
    setState(() {
      _selectedFilter = filter;
      if (filter == 'Importance') {
        foundToDo.sort(
          (a, b) => b.taskPriority.index.compareTo(a.taskPriority.index),
        );
      } else if (filter == 'Recent to Oldest') {
        foundToDo.sort((a, b) => a.formattedDate.compareTo(b.formattedDate));
      } else if (filter == 'Oldest to Recent') {
        foundToDo.sort((a, b) => b.formattedDate.compareTo(a.formattedDate));
      } else {
        foundToDo = todosList;
      }
    });
  }

  void runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) =>
              item.title!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      foundToDo = results;
    });
  }
}
