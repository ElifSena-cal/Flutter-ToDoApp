import 'dart:ffi';

import 'package:flutter_application_2/db/dp_helper.dart';
import 'package:flutter_application_2/models/task.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTask();
    super.onReady();
  }

  var taskList = <Task>[].obs;
  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  void getTask() async {
    print("get task called");
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    DBHelper.delete(task);
    getTask();
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTask();
  }
}
