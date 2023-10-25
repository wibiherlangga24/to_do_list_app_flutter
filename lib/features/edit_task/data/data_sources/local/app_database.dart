import 'package:floor/floor.dart';
import 'package:todo_list_app_flutter/features/add_task/data/data_sources/local/DAO/task_dao.dart';
import 'package:todo_list_app_flutter/features/add_task/data/models/task_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'app_database.g.dart';

@Database(version: 1, entities: [TaskModel])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDAO;
}
