import 'package:assignments/models/database_models/local_list.dart';
import 'package:assignments/resources/app_colors.dart';
import 'package:assignments/resources/app_text_style.dart';
import 'package:assignments/utils/riverpod_utils/all_riverpod_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListPage extends ConsumerStatefulWidget {
  const TodoListPage({super.key});

  @override
  ConsumerState<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends ConsumerState<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    final todoList = ref.watch(todoListProvider);
    final todoListNotifier = ref.read(todoListProvider.notifier);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Todo List',
            style: AppTextStyle.twentyNormalBlackText,
          ),
          backgroundColor: AppColors.amber,
          actions: [
            IconButton(
              onPressed: () async {
                await todoListNotifier.clearTodos();
              },
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
        body: todoList.isEmpty
            ? const Center(
                child: Text(
                  'No Todo Added',
                  style: AppTextStyle.twentyNormalBlackText,
                ),
              )
            : ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  final data = todoList[index];
                  return ListTile(
                    leading: IconButton(
                      onPressed: () async {
                        LocalIsarModel updateTodo = LocalIsarModel();
                        updateTodo.isCompleted = !data.isCompleted!;
                        await todoListNotifier.updateTodo(data.id, updateTodo);
                      },
                      icon: const Icon(Icons.check_circle_outline),
                    ),
                    title: Text(
                      data.title!,
                      style: AppTextStyle.twentyNormalBlackText,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () async {
                        await todoListNotifier.deleteTodo(data.id);
                      },
                    ),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.amber,
          onPressed: () async {
            final TextEditingController titleController = TextEditingController();

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Add Title"),
                  content: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: "Enter title"),
                  ),
                  actions: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: const Text("Submit"),
                      onPressed: () async {
                        String title = titleController.text.trim();
                        LocalIsarModel newTodo = LocalIsarModel();
                        newTodo.title = title;
                        await todoListNotifier.addTodo(newTodo);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(
            Icons.add,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
