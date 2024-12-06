import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChange;
  final onDeleteItem;

  const ToDoItem({
    super.key,
    required this.todo,
    required this.onToDoChange,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChange(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: green3,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: green1,
        ),
        title: Text(
          todo.title!,
          style: const TextStyle(
            fontSize: 16,
            color: green1,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: PopupMenuButton<String>(
          color: green4,
          icon: const Icon(Icons.more_vert, color: green1),
          onSelected: (String value) {
            if (value == 'delete') {
              onDeleteItem(todo.id);
            } else {
              onShowDetails(context);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
                value: 'delete',
                child: Text(
                  'Delete',
                  style:
                      TextStyle(color: green1, fontWeight: FontWeight.w600),
                )),
            const PopupMenuItem<String>(
                value: 'details',
                child: Text(
                  'Details',
                  style:
                      TextStyle(color: green1, fontWeight: FontWeight.w600),
                )),
          ],
        ),
      ),
    );
  }
  void onShowDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(todo.title!),
          content: Text("Priority: ${todo.taskPriority.toString().toUpperCase()}\n"
              "Type: ${todo.taskType.toString().toUpperCase()}\n"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"))
          ],
        );
      },
    );
  }
}
