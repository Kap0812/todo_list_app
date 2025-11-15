import 'package:flutter/foundation.dart';
import '../models/todo.dart';
import '../services/storage_service.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;
  List<Todo> get completedTodos => _todos.where((todo) => todo.isCompleted).toList();
  List<Todo> get pendingTodos => _todos.where((todo) => !todo.isCompleted).toList();

  TodoProvider() {
    loadTodos();
  }

  Future<void> loadTodos() async {
    _todos = StorageService.getTodos();
    notifyListeners();
  }

  Future<void> addTodo(Todo todo) async {
    await StorageService.addTodo(todo);
    await loadTodos();
  }

  Future<void> toggleTodoStatus(String id) async {
    final todo = _todos.firstWhere((todo) => todo.id == id);
    todo.isCompleted = !todo.isCompleted;
    await StorageService.updateTodo(todo);
    await loadTodos();
  }

  Future<void> deleteTodo(String id) async {
    await StorageService.deleteTodo(id);
    await loadTodos();
  }

  Future<void> updateTodo(Todo updatedTodo) async {
    await StorageService.updateTodo(updatedTodo);
    await loadTodos();
  }
}