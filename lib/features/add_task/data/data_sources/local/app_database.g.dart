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

  UserDao? _userDAOInstance;

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
            'CREATE TABLE IF NOT EXISTS `task` (`id` INTEGER, `title` TEXT, `dateTime` TEXT, `description` TEXT, `status` INTEGER, `userId` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user` (`name` TEXT, `email` TEXT, `password` TEXT, PRIMARY KEY (`email`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TaskDao get taskDAO {
    return _taskDAOInstance ??= _$TaskDao(database, changeListener);
  }

  @override
  UserDao get userDAO {
    return _userDAOInstance ??= _$UserDao(database, changeListener);
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
                  'status': item.status,
                  'userId': item.userId
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
                  'status': item.status,
                  'userId': item.userId
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
                  'status': item.status,
                  'userId': item.userId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TaskModel> _taskModelInsertionAdapter;

  final UpdateAdapter<TaskModel> _taskModelUpdateAdapter;

  final DeletionAdapter<TaskModel> _taskModelDeletionAdapter;

  @override
  Future<List<TaskModel>> getTasks(
    String date,
    String email,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM task WHERE dateTime = ?1 AND userId = ?2',
        mapper: (Map<String, Object?> row) => TaskModel(
            id: row['id'] as int?,
            title: row['title'] as String?,
            dateTime: row['dateTime'] as String?,
            description: row['description'] as String?,
            status: row['status'] as int?,
            userId: row['userId'] as String?),
        arguments: [date, email]);
  }

  @override
  Future<List<TaskModel>> getTasksById(int id) async {
    return _queryAdapter.queryList('SELECT * FROM task WHERE id = ?1',
        mapper: (Map<String, Object?> row) => TaskModel(
            id: row['id'] as int?,
            title: row['title'] as String?,
            dateTime: row['dateTime'] as String?,
            description: row['description'] as String?,
            status: row['status'] as int?,
            userId: row['userId'] as String?),
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

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userModelInsertionAdapter = InsertionAdapter(
            database,
            'user',
            (UserModel item) => <String, Object?>{
                  'name': item.name,
                  'email': item.email,
                  'password': item.password
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserModel> _userModelInsertionAdapter;

  @override
  Future<List<UserModel>> findEmailUser(String email) async {
    return _queryAdapter.queryList('SELECT * FROM user WHERE email = ?1',
        mapper: (Map<String, Object?> row) => UserModel(
            name: row['name'] as String?,
            email: row['email'] as String?,
            password: row['password'] as String?),
        arguments: [email]);
  }

  @override
  Future<List<UserModel>> loginUser(
    String email,
    String password,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM user WHERE email = ?1 AND password = ?2',
        mapper: (Map<String, Object?> row) => UserModel(
            name: row['name'] as String?,
            email: row['email'] as String?,
            password: row['password'] as String?),
        arguments: [email, password]);
  }

  @override
  Future<void> registerUser(UserModel user) async {
    await _userModelInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }
}
