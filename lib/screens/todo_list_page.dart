import 'package:assignments/models/database_models/local_list.dart';
import 'package:assignments/resources/custom_toast_message.dart';
import 'package:assignments/resources/styling/app_colors.dart';
import 'package:assignments/resources/styling/app_text_style.dart';
import 'package:assignments/resources/styling/global_device_size.dart';
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
            style: AppTextStyle.twentySemiBoldBlackText,
          ),
          backgroundColor: AppColors.amber,
          actions: [
            if (todoList.isNotEmpty)
              IconButton(
                onPressed: () async {
                  await todoListNotifier.clearTodos().then((value) {
                    CustomToast.toastMessage(context, "All Todos Cleared!");
                  });
                },
                icon: const Icon(Icons.delete_outline),
              ),
          ],
        ),
        body: todoList.isEmpty
            ? const Center(
                child: Text(
                  'No Todo Added',
                  style: AppTextStyle.sixteenNormalBlackText,
                ),
              )
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: DeviceSize.height(context) * 0.015, vertical: DeviceSize.height(context) * 0.02),
                itemCount: todoList.length,
                separatorBuilder: (context, index) => SizedBox(height: DeviceSize.height(context) * 0.015),
                itemBuilder: (context, index) {
                  final data = todoList[index];
                  return ListTile(
                    leading: IconButton(
                      onPressed: () async {
                        LocalIsarModel updateTodo = LocalIsarModel();
                        updateTodo.isCompleted = !data.isCompleted!;
                        await todoListNotifier.updateTodo(data.id, updateTodo);
                      },
                      icon: Icon(
                        data.isCompleted! ? Icons.check_box : Icons.check_box_outline_blank,
                        color: data.isCompleted! ? AppColors.green : AppColors.grey,
                      ),
                    ),
                    title: Text(
                      data.title!,
                      style: data.isCompleted! ? AppTextStyle.sixteenNormalLineThroughGreyText : AppTextStyle.sixteenNormalBlackText,
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                      ),
                      onPressed: () async {
                        await todoListNotifier.deleteTodo(data.id);
                      },
                    ),
                    horizontalTitleGap: 6,
                    contentPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    tileColor: AppColors.lightGrey.withOpacity(0.1),
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
                        if (titleController.text.trim().isEmpty) {
                          CustomToast.toastMessage(context, "Please enter title");
                          return;
                        }
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
