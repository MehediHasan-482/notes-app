import '../entities/note_entity.dart';

abstract class NotesRepository {
  Future<List<NoteEntity>> getNotes();
  Future<void> addNote({required String title, required String description});
  Future<void> deleteNote(String noteId);
}