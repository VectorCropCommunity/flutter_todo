import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:flutter_todo/app/todo_model.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the TodoProvider and open the database connection
  final todoProvider = TodoProvider();
  await todoProvider.open();

  runApp(
    GetMaterialApp(
      title: "My Todo",
      initialRoute: AppPages.INITIAL,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
      getPages: AppPages.routes,
    ),
  );
}
