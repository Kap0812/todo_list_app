import 'package:hive_flutter/hive_flutter.dart';
import '../models/todo.dart';

class StorageService {
  static late Box<Todo> _todoBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TodoAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(PriorityAdapter());
    }
    _todoBox = await Hive.openBox<Todo>('todos');
  }

  static List<Todo> getTodos() {
    return _todoBox.values.toList();
  }

  static Future<void> addTodo(Todo todo) async {
    await _todoBox.put(todo.id, todo);
  }

  static Future<void> updateTodo(Todo todo) async {
    await _todoBox.put(todo.id, todo);
  }

  static Future<void> deleteTodo(String id) async {
    await _todoBox.delete(id);
  }

  static Future<void> clearAll() async {
    await _todoBox.clear();
  }
}