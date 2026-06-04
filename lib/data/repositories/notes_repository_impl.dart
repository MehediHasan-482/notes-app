import 'package:notesapp/data/datasources/supabase_datasource.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/notes_repository.dart';


class NotesRepositoryImpl implements NotesRepository {
  final SupabaseDataSource _dataSource;
  
  NotesRepositoryImpl(this._dataSource);
  
  @override
  Future<List<NoteEntity>> getNotes() async {
    final notesData = await _dataSource.getNotes();
    return notesData.map((map) => NoteEntity(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'],
      description: map['description'],
      createdAt: DateTime.parse(map['created_at']),
    )).toList();
  }
  
  @override
  Future<void> addNote({required String title, required String description}) async {
    await _dataSource.addNote(title, description);
  }
  
  @override
  Future<void> deleteNote(String noteId) async {
    await _dataSource.deleteNote(noteId);
  }
}