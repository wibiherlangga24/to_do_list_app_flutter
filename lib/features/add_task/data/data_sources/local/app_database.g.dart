// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TaskDao? _taskDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `task` (`id` INTEGER, `title` TEXT, `dateTime` TEXT, `description` TEXT, `status` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TaskDao get taskDAO {
    return _taskDAOInstance ??= _$TaskDao(database, changeListener);
  }
}

class _$TaskDao extends TaskDao {
  _$TaskDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _taskModelInsertionAdapter = InsertionAdapter(
            database,
            'task',
            (TaskModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'dateTime': item.dateTime,
                  'description': item.description,
                  'status': item.status
                }),
        _taskModelUpdateAdapter = UpdateAdapter(
            database,
            'task',
            ['id'],
            (TaskModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'dateTime': item.dateTime,
                  'description': item.description,
                  'status': item.status
                }),
        _taskModelDeletionAdapter = DeletionAdapter(
            database,
            'task',
            ['id'],
            (TaskModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'dateTime': item.dateTime,
                  'description': item.description,
                  'status': item.status
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TaskModel> _taskModelInsertionAdapter;

  final UpdateAdapter<TaskModel> _taskModelUpdateAdapter;

  final DeletionAdapter<TaskModel> _taskModelDeletionAdapter;

  @override
  Future<List<TaskModel>> getTasks(String date) async {
    return _queryAdapter.queryList('SELECT * FROM task WHERE dateTime = ?1',
        mapper: (Map<String, Object?> row) => TaskModel(
            id: row['id'] as int?,
            title: row['title'] as String?,
            dateTime: row['dateTime'] as String?,
            description: row['description'] as String?,
            status: row['status'] as int?),
        arguments: [date]);
  }

  @override
  Future<List<TaskModel>> getTasksById(int id) async {
    return _queryAdapter.queryList('SELECT * FROM task WHERE id = ?1',
        mapper: (Map<String, Object?> row) => TaskModel(
            id: row['id'] as int?,
            title: row['title'] as String?,
            dateTime: row['dateTime'] as String?,
            description: row['description'] as String?,
            status: row['status'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> insertTask(TaskModel task) async {
    await _taskModelInsertionAdapter.insert(task, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    await _taskModelUpdateAdapter.update(task, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTask(TaskModel task) async {
    await _taskModelDeletionAdapter.delete(task);
  }
}
