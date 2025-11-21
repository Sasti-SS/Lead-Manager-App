import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/lead_model.dart';

class DBHelper {
  static Database? _db;
  static final DBHelper _instance = DBHelper._internal();
  DBHelper._internal();
  factory DBHelper() => _instance;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'leads.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE leads(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          contact TEXT NOT NULL,
          notes TEXT,
          status TEXT NOT NULL
        )
      ''');
    });
  }

  Future<int> insertLead(LeadModel lead) async {
    final db = await database;
    return await db.insert('leads', lead.toMap());
  }

  Future<List<LeadModel>> getLeads() async {
    final db = await database;
    final result = await db.query('leads', orderBy: 'id DESC');
    return result.map((e) => LeadModel.fromMap(e)).toList();
  }

  Future<int> updateLead(LeadModel lead) async {
    final db = await database;
    return await db.update('leads', lead.toMap(), where: 'id = ?', whereArgs: [lead.id]);
  }

  Future<int> deleteLead(int id) async {
    final db = await database;
    return await db.delete('leads', where: 'id = ?', whereArgs: [id]);
  }
}
