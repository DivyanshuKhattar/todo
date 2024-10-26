import 'package:assignments/database_helper/local_list_helper.dart';
import 'package:assignments/models/database_models/local_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListNotifier extends StateNotifier<List<LocalIsarModel>> {
  final LocalDatabase localDatabase;

  TodoListNotifier(this.localDatabase) : super([]) {
    fetchTodos();
  }

  Future fetchTodos() async {
    await localDatabase.fetchTodo();
    state = List.from(localDatabase.localList);
  }

  Future addTodo(LocalIsarModel newTodo) async {
    await localDatabase.addTodo(newTodo);
    fetchTodos();
  }

  Future updateTodo(int id, LocalIsarModel newTodo) async {
    await localDatabase.updateTodo(id, newTodo);
    fetchTodos();
  }

  Future deleteTodo(int id) async {
    await localDatabase.deleteTodo(id);
    fetchTodos();
  }

  Future clearTodos() async {
    await localDatabase.truncateTodo();
    fetchTodos();
  }
}
