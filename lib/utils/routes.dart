import 'package:assignments/screens/todo_list_page.dart';
import 'package:flutter/material.dart';

// Navigator.pushNamed(context, '/second');
// Navigator.pushNamedAndRemoveUntil(context, '/welcome', ModalRoute.withName('/welcome'));

final Map<String, Widget Function(BuildContext)> namedRoutes = {
  '/todo_screen': (context) => const TodoListPage(),
};
