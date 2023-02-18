import 'package:simple_note_app/model/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

  //checking if database already available
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
                  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
                  title TEXT,
                  desc TEXT
                )
            ''');
    }, version: 1);
  }

  //add new note to table
  addNewNote(NoteModel note) async {
    final db = await database;
    db?.insert(
      "notes",
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //getting the notes as list
  Future<dynamic> getNotes() async {
    final db = await database;
    var res = await db?.query("notes");
    if (res!.isEmpty) {
      return null;
    } else {
      var resultMap = res.toList();
      return resultMap.isNotEmpty ? resultMap : null;
    }
  }

  Future<dynamic> readNote(int id) async {
    final db = await database;
    var list = await db!.rawQuery('SELECT * FROM Notes WHERE id = ?', [id]);
    return list;
  }

  updateNote(String title, String desc, int id) async {
    final db = await database;
    await db!.rawUpdate(
        'UPDATE notes SET title = ?, desc = ? WHERE id =?', [title, desc, id]);
  }

  Future<void> deleteNote(int id) async {
    final db = await database;
    await db!.rawDelete('DELETE FROM notes WHERE id = ?', [id]);
  }
}
