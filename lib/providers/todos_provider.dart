import 'package:flutter_application_2/models/todo_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todos_provider.g.dart';

@riverpod
class Todos extends _$Todos {
  @override
  List<TodoModel> build() {
    return [];
  }

  void addTodo(TodoModel todo) {
    state = [...state, todo];
  }

  void toggleTodo(int id, bool isCompleted) {
    state = state
        .map((todo) =>
            todo.id == id ? todo.copyWith(completed: isCompleted) : todo)
        .toList();
  }

  void deleteTodo(int id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}
