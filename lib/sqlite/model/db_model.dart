import 'package:sqflite/sqlite_api.dart';

import 'base_model.dart';

class db_model extends ModelBase {
  final Database db;

  db_model({required this.db});
}
