class NoteEntity {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime createdAt;

  const NoteEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.createdAt,
  });
}