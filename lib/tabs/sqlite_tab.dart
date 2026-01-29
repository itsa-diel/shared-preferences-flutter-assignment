import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SqliteTab extends StatefulWidget {
  final Function(String) onUpdate;
  const SqliteTab({Key? key, required this.onUpdate}) : super(key: key);

  @override
  _SqliteTabState createState() => _SqliteTabState();
}

class _SqliteTabState extends State<SqliteTab> {
  Database? db;

  @override
  void initState() {
    super.initState();
    _initDb();
    _loadData();
  }

  Future<void> _initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'test.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE test(id INTEGER PRIMARY KEY, data TEXT)',
        );
      },
    );
  }

  Future<void> saveData() async {
    if (db != null) {
      await db!.insert('test', {'data': 'Hello SQLite!'}, 
          conflictAlgorithm: ConflictAlgorithm.replace);
      widget.onUpdate('Hello SQLite!');
    }
  }

  Future<void> _loadData() async {
    if (db != null) {
      final maps = await db!.query('test');
      final data = maps.isNotEmpty ? maps.last['data'] : 'No data';
      widget.onUpdate(data.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: saveData, child: Text('Save')),
          SizedBox(height: 20),
          ElevatedButton(onPressed: _loadData, child: Text('Load')),
          SizedBox(height: 20),
          Text('SQLite: Relational database'),
        ],
      ),
    );
  }
}
