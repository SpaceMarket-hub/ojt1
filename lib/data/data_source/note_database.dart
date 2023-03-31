import 'package:memojt/domain/model/note.dart';
import 'package:memojt/domain/repository/note_repository.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabase implements NoteRepository {
  static const _databaseName = 'notes.db';
  static const _databaseVersion = 1;
  Database? _database;

  @override
  Future<void> addNote(Note note) async {
    // TODO: implement addNote => change to Future
    final db = await _getDatabase();
    await db.insert(Note.tableName, note.toRow());
  }

  @override
  Future<void> deleteNote(int id) async {
    final db = await _getDatabase();
    await db.delete(
      Note.tableName,
      where: '${Note.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<Note> getNote(int id) async { // can't override?
    final db = await _getDatabase();
    final rows = await db.query(
      Note.tableName,
      where: '${Note.columnId} = ?',
      whereArgs: [id],
    );
    return Note.fromRow(rows.single);
  }
  // up & down methods are independent for return values.
  Future<List<Note>> listNotes() async {
    final db = await _getDatabase();
    final rows = await db.query(Note.tableName);
    return rows.map((row) => Note.fromRow(row)).toList();
  }

  @override
  void updateNote(int index, Note note) {
    // TODO: implement updateNote
  }

  Future<Database> _getDatabase() async {
    _database ??= await openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: (db, version) {
        const sql = '''
          CREATE TABLE ${Note.tableName} (
          ${Note.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${Note.columnTitle} TEXT,
          ${Note.columnBody} TEXT NOT NULL,
          ${Note.columnColor} INTEGER NOT NULL,
          )        
          ''';
        return db.execute(sql);
      },
    );
    return _database!;
  }

  @override
  Note getNoteRepository(int index) {
    // TODO: implement getNoteRepository
    throw UnimplementedError();
  }

  @override
  List<Note> listNoteRepositories() {
    // TODO: implement listNoteRepositories
    throw UnimplementedError();
  }
}