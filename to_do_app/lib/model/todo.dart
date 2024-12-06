import 'package:intl/intl.dart';

enum TaskPriority { low, medium, high }

extension TaskPriorityExtension on TaskPriority {
  String get asString {
    switch (this) {
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
    }
  }

  static TaskPriority fromString(String value) {
    switch (value) {
      case 'Low':
        return TaskPriority.low;
      case 'Medium':
        return TaskPriority.medium;
      case 'High':
        return TaskPriority.high;
      default:
        throw ArgumentError('Unknown Importance value: $value');
    }
  }
}

enum TaskType {
  work,
  school,
  family,
  friends,
  sport,
  vacation,
  birthday,
  anniversary,
  appointment,
  social,
  other,
}

extension TaskTypeExtension on TaskType {
  String get asString {
    return toString().split('.').last;
  }

  static TaskType fromString(String value) {
    return TaskType.values
        .firstWhere((e) => e.toString().split('.').last == value);
  }
}

class ToDo {
  String? id;
  String? title;
  DateTime? date;
  TaskPriority taskPriority;
  TaskType taskType;
  bool isDone;

  ToDo({
    required this.id,
    required this.title,
    required this.date,
    required this.taskPriority,
    required this.taskType,
    this.isDone = false,
  });

  String get formattedDate => DateFormat('dd/MM/yyyy').format(date!);

  ToDo.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        date = DateFormat('dd/MM/yyyy').parse(json['date']),
        title = json['title'],
        taskPriority = TaskPriorityExtension.fromString(json['taskImportance']),
        taskType = TaskTypeExtension.fromString(json['taskType']),
        isDone = json['isDone'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': DateFormat('dd/MM/yyyy').format(date!),
      'title': title,
      'taskImportance': taskPriority.asString,
      'taskType': taskType.asString,
      'isDone': isDone,
    };
  }

  static List<ToDo> todoList = [
    ToDo(
        id: '01',
        title: 'Morning Exercises',
        date: DateTime.now(),
        taskPriority: TaskPriority.medium,
        taskType: TaskType.sport,
        isDone: true),
    ToDo(
        id: '02',
        title: 'Buy Groceries',
        date: DateTime.now(),
        taskPriority: TaskPriority.low,
        taskType: TaskType.other,
        isDone: true),
    ToDo(
        id: '03',
        title: 'Check Emails',
        date: DateTime.now(),
        taskPriority: TaskPriority.high,
        taskType: TaskType.work),
    ToDo(
        id: '04',
        title: 'Team Meeting',
        date: DateTime.now(),
        taskPriority: TaskPriority.high,
        taskType: TaskType.work),
    ToDo(
        id: '05',
        title: 'Work on mobile apps for 2 hour',
        date: DateTime.now(),
        taskPriority: TaskPriority.low,
        taskType: TaskType.school),
    ToDo(
        id: '06',
        title: 'Dinner with Harry',
        date: DateTime.now(),
        taskPriority: TaskPriority.high,
        taskType: TaskType.family),
  ];
}
