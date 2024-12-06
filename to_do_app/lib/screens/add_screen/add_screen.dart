import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/screens/add_screen/widgets/add_app_bar.dart';
import '../../constants/colors.dart';
import '../../data/data_manager.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final todosList = ToDo.todoList;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  TaskPriority _selectedPriority = TaskPriority.low;
  TaskType _selectedType = TaskType.other;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AddAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "TITLE",
                  style: TextStyle(
                    color: green1,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter To Do Title',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: green1,
                        width: 2.0,
                      ),
                    ),
                    fillColor: white,
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  "DATE",
                  style: TextStyle(
                    color: green1,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    hintText: 'Select a Date',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                      color: green1,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: green1,
                        width: 2.0,
                      ),
                    ),
                    fillColor: white,
                    filled: true,
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  "TASK TYPE",
                  style: TextStyle(
                    color: green1,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<TaskType>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: green1,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: green1,
                        width: 2.0,
                      ),
                    ),
                    fillColor: white,
                    filled: true,
                  ),
                  value: _selectedType,
                  iconEnabledColor: green1,
                  iconDisabledColor: grey1,
                  onChanged: (TaskType? newValue) {
                    setState(() {
                      _selectedType = newValue!;
                    });
                  },
                  items: TaskType.values.map((TaskType type) {
                    return DropdownMenuItem<TaskType>(
                      value: type,
                      child: Text(
                        type.toString().split('.').last.toUpperCase(),
                        style: const TextStyle(
                          color: grey1,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text(
                  "TASK PRIORITY",
                  style: TextStyle(
                    color: green1,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<TaskPriority>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: green1,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: green1,
                        width: 2.0,
                      ),
                    ),
                    fillColor: white,
                    filled: true,
                  ),
                  value: _selectedPriority,
                  iconEnabledColor: green1,
                  iconDisabledColor: grey1,
                  onChanged: (TaskPriority? newValue) {
                    setState(() {
                      _selectedPriority = newValue!;
                    });
                  },
                  items: TaskPriority.values.map((TaskPriority priority) {
                    return DropdownMenuItem<TaskPriority>(
                      value: priority,
                      child: Text(
                        priority.toString().split('.').last.toUpperCase(),
                        style: const TextStyle(
                          color: grey1,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: green3,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_selectedDate != null) {
                            final newToDo = ToDo(
                              id: DateTime.now()
                                  .microsecondsSinceEpoch
                                  .toString(),
                              date: _selectedDate!,
                              title: _titleController.text,
                              taskPriority: _selectedPriority,
                              taskType: _selectedType,
                            );
                            addNewToDoItem(newToDo);
                            clearForm();
                          }
                        }
                      },
                      child: const Text(
                        'ADD',
                        style: TextStyle(
                          color: green1,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addNewToDoItem(ToDo newToDo) {
    setState(() {
      ToDo.todoList.add(newToDo);
    });
    DataManager.saveTodoList(todosList);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  void clearForm() {
    setState(() {
      _titleController.clear();
      _dateController.clear();
      _selectedPriority = TaskPriority.low;
      _selectedType = TaskType.other;
      _selectedDate = null;
    });
  }
}
