import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    final path = await getDatabasesPath();
    return await openDatabase(
      join(path, 'quran_bookmarks.db'),
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE bookmarks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            surahNumber INTEGER,
            ayahNumber INTEGER,
            ayahText TEXT,
            audioUrl TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE last_read(
            id INTEGER PRIMARY KEY DEFAULT 1,
            surahNumber INTEGER,
            ayahNumber INTEGER,
            surahName TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE last_read(
              id INTEGER PRIMARY KEY DEFAULT 1,
              surahNumber INTEGER,
              ayahNumber INTEGER,
              surahName TEXT
            )
          ''');
        }
      },
    );
  }

  //  Add bookmark
  Future<int> addBookmark(Map<String, dynamic> row) async {
    final db = await database;
    return await db.insert('bookmarks', row, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //  Remove bookmark
  Future<int> removeBookmark(int surahNumber, int ayahNumber) async {
    final db = await database;
    return await db.delete(
      'bookmarks',
      where: 'surahNumber = ? AND ayahNumber = ?',
      whereArgs: [surahNumber, ayahNumber],
    );
  }

  //  Get all bookmarks
  Future<List<Map<String, dynamic>>> getBookmarks() async {
    final db = await database;
    return await db.query('bookmarks', orderBy: 'id DESC');
  }

  //  Check if bookmark exists
  Future<bool> isBookmarked(int surahNumber, int ayahNumber) async {
    final db = await database;
    final res = await db.query(
      'bookmarks',
      where: 'surahNumber = ? AND ayahNumber = ?',
      whereArgs: [surahNumber, ayahNumber],
    );
    return res.isNotEmpty;
  }

  // Save Last Read Position
  Future<void> saveLastRead(int surahNumber, int ayahNumber, String surahName) async {
    final db = await database;
    await db.insert(
      'last_read',
      {
        'id': 1,
        'surahNumber': surahNumber,
        'ayahNumber': ayahNumber,
        'surahName': surahName,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get Last Read
  Future<Map<String, dynamic>?> getLastRead() async {
    final db = await database;
    final res = await db.query('last_read', where: 'id = ?', whereArgs: [1]);
    if (res.isNotEmpty) return res.first;
    return null;
  }
}
