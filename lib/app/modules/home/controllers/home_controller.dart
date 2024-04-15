import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter_todo/app/modules/components/constants.dart';
import 'package:flutter_todo/app/todo_model.dart';

class HomeController extends GetxController {
  final TodoProvider provider = TodoProvider();
  RxList<Todo> todos = <Todo>[].obs;
  RxList<Todo> completedTodo = <Todo>[].obs;
  RxList<Todo> pendingTodo = <Todo>[].obs;

  late AnimationController animController;
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  RxString title = "".obs;
  Rx<DateTime> date = DateTime.now().obs;
  Rx<TimeOfDay> time = TimeOfDay.now().obs;
  RxString description = "No Description".obs;
  RxString category = "".obs;
  Rx<DateTime> newDate = DateTime.now().obs;

  RxInt selectCatIndex = 1.obs;
  RxBool saving = false.obs;

  @override
  void onInit() {
    readData();
    super.onInit();
  }

  @override
  void onClose() {
    provider.close();
    super.onClose();
  }

  void readData() async {
    await provider.open().then(
      (value) async {
        List<Todo> fetchedTodos = await provider.getAllTodos();
        todos.value = fetchedTodos
            .where((element) =>
                DateFormat(DateFormat.YEAR_NUM_MONTH_DAY)
                    .format(DateTime.parse(element.createdAt)) ==
                DateFormat(DateFormat.YEAR_NUM_MONTH_DAY)
                    .format(DateTime.now()))
            .toList(); // Update the reactive list
        pendingTodo.value =
            fetchedTodos.where((element) => !element.status).toList();
        completedTodo.value =
            fetchedTodos.where((element) => element.status).toList();

        print(pendingTodo.length);
      },
    );

    print("read");
  }

  void updateData(Todo todo, bool newStatus) {
    todo.status = newStatus;
    provider.update(todo); // Update the todo in the database
    readData(); // Refresh the list of todos
  }

  void deleteData(Todo todo) {
    provider.delete(todo.id);
    readData();
  }

  Future<void> createData() async {
    if (title.value.trim() == "" ||
        date.value.toString() == "" ||
        time.value.toString() == "") {
      Get.showSnackbar(GetSnackBar(
        title: "Error",
        message: "Enter a valid title",
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
      return;
    }
    ;

    saving.value = true;
    description.value = descriptionController.value.text;
    newDate.value = DateTime(date.value.year, date.value.month, date.value.day,
        time.value.hour, time.value.minute);

    //category
    if (selectCatIndex == 1) {
      category.value = CAT_NOTES;
    } else if (selectCatIndex == 2) {
      category.value = CAT_DATE;
    } else {
      category.value = CAT_CHAMP;
    }

    // Create a new Todo object
    Todo todo = Todo();
    todo.title = title.value;
    todo.description = description.value;
    todo.status = false; // Set the status
    todo.category = category.value;
    todo.dueDate = newDate.toString(); // Set the due date
    todo.createdAt = DateTime.now().toString(); // Set the creation date
    todo.updatedAt = DateTime.now().toString(); // Set the updated date

    // Open the database connection
    await provider.open();

    // Insert the todo into the database
    await provider.insert(todo);
    saving.value = false;

    titleController.text = "";
    dateController.text = "";
    timeController.text = "";
    descriptionController.text = "";
    title.value = "";

    readData();

    Get.back();
  }

  void changeDate(DateTime dateTime) {
    date.value = dateTime;
    newDate.value = DateTime(date.value.year, date.value.month, date.value.day,
        time.value.hour, time.value.minute);
    dateController.text =
        DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(dateTime);
  }

  void changeTime(TimeOfDay timeOfDay) {
    time.value = timeOfDay;
    newDate.value = DateTime(date.value.year, date.value.month, date.value.day,
        time.value.hour, time.value.minute);
    timeController.text =
        DateFormat(DateFormat.HOUR_MINUTE).format(newDate.value);
  }

  void changeCat(index) {
    selectCatIndex.value = index;
  }
}
