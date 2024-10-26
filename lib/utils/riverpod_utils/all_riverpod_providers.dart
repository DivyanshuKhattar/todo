import 'package:assignments/database_helper/local_list_helper.dart';
import 'package:assignments/models/database_models/local_list.dart';
import 'package:assignments/utils/riverpod_utils/todo_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Task List Provider
final todoListProvider = StateNotifierProvider<TodoListNotifier, List<LocalIsarModel>>((ref) => TodoListNotifier(LocalDatabase()));
