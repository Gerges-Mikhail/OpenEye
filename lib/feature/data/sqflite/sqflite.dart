import 'package:open_eye/feature/data/model/notesModel.dart';
import 'package:open_eye/feature/data/model/phoneNumberModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(join(path, "database.db"),
        onCreate: (database, verison) async {
          await database.execute("""
        CREATE TABLE notesTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        subtitle TEXT NOT NULL
        )
        """);
          await database.execute("""
        CREATE TABLE phoneNumberTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phoneNumber TEXT NOT NULL
        )
        """);
        },
        version: 1
    );
  }
  Future<bool> insertNotesData(NoteModel noteModel) async {
    final Database db = await initDB();
    db.insert("notesTable", noteModel.toMap());
    return true;
  }

  Future<bool> insertPhoneNumberData(PhoneNumberModel phoneNumberModel) async {
    final Database db = await initDB();
    db.insert("phoneNumberTable", phoneNumberModel.toMap());
    return true;
  }

  Future<List<NoteModel>> getNotesData() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> datas = await db.query("notesTable");
    return datas.map((e) => NoteModel.fromMap(e)).toList();
  }

  Future<List<PhoneNumberModel>> getPhoneNumberData() async {
    final Database db = await initDB();
    final List<Map<String, Object?>> datas = await db.query("phoneNumberTable");
    return datas.map((e) => PhoneNumberModel.fromMap(e)).toList();
  }

  Future<void> update(NoteModel noteModel, int id) async {
    final Database db = await initDB();
    await db
        .update("notesTable", noteModel.toMap(), where: "id=?", whereArgs: [id]);
  }

  Future<void> deleteNotesData(int id) async {
    final Database db = await initDB();
    await db.delete("notesTable", where: "id=?", whereArgs: [id]);
  }

  Future<void> deletePhoneNumberData(int id) async {
    final Database db = await initDB();
    await db.delete("phoneNumberTable", where: "id=?", whereArgs: [id]);
  }
}
