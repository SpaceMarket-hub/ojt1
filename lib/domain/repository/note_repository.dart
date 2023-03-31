import 'package:memojt/domain/model/note.dart';

class NoteRepository {
  final List<Note> _notes = [];

  void addNote(Note note) {
    _notes.add(note);
  }
  void deleteNote(int index) {
    _notes.removeAt(index);
  }
  Note getNoteRepository(int index) {
    return _notes[index];
  }
  List<Note> listNoteRepositories() {
    return _notes;
  }
  void updateNote(int index, Note note) {
    _notes[index] = note;
  }
}