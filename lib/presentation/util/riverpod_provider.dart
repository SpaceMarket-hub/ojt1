import 'package:memojt/data/data_source/note_database.dart';

NoteDatabase? _noteDatabase;

NoteDatabase noteDatabase() {
  _noteDatabase ??= NoteDatabase();
  return _noteDatabase!;
}