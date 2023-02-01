import 'package:simple_note_app/model/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  //create new table
  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "notes.db"),
        onCreate: (db, version) async {
      await db.execute('''
                CREATE TABLE notes(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  title TEXT,
                  desc TEXT,
                )
            ''');
    }, version: 1);
  }

  //add new note to table
  addNewNote(NoteModel note) async {
    final db = await database;
    db!.insert(
      "notes",
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //getting the notes as list
  Future<dynamic> getNotes() async {
    final db = await database;
    var res = await db!.query("notes");
    if (res.isEmpty) {
      return Null;
    } else {
      var resultMap = res.toList();
      return resultMap;
    }
  }
}
