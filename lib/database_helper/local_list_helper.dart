import 'package:assignments/models/database_models/local_list.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LocalDatabase {
  static late Isar isar;
  final List<LocalIsarModel> localList = [];

  /// initialize
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [LocalIsarModelSchema],
      directory: dir.path,
      name: "localDb",
    );
  }

  /// ******************************* [ QUERIES TO PERFORM ] ****************************
  // create
  Future<void> addTodo(LocalIsarModel todo) async {
    final newTodo = LocalIsarModel()
      ..title = todo.title
      ..isCompleted = todo.isCompleted;
    await isar.writeTxn(() => isar.localIsarModels.put(newTodo));
    await fetchTodo();
  }

  // read
  Future<List<LocalIsarModel>> fetchTodo() async {
    List<LocalIsarModel> fetchFestivals = await isar.localIsarModels.where().findAll();
    localList.clear();
    localList.addAll(fetchFestivals);
    return localList;
  }

  // update
  Future<void> updateTodo(int id, LocalIsarModel todo) async {
    final existingTodo = await isar.localIsarModels.get(id);
    if (existingTodo != null) {
      existingTodo.isCompleted = todo.isCompleted;
      await isar.writeTxn(() => isar.localIsarModels.put(existingTodo));
      await fetchTodo();
    }
  }

  // delete
  Future<void> deleteTodo(int id) async {
    await isar.writeTxn(() => isar.localIsarModels.delete(id));
    await fetchTodo();
  }

  // truncate
  Future<void> truncateTodo() async {
    try {
      await isar.writeTxn(() => isar.localIsarModels.clear());
      await fetchTodo();
      // isar.close(deleteFromDisk: true);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

/// use anywhere like this
// localDatabase.deleteTodo(1);
// localDatabase.updateTodo(2, "meow");
// localDatabase.truncateTodo();
// print(localDatabase.localList.length);
// await localDatabase.addTodo("meow");
