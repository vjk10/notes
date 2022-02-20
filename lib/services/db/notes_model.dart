const String tableNotes = 'NOTES';

class NoteFields {
  static final List<String> values = [
    id,
    title,
    body,
    creationTime,
  ];
  static const String id = '_id';
  static const String title = '_title';
  static const String body = '_body';
  static const String creationTime = '_creationTime';
}

class Note {
  final int? id;
  final String title;
  final String body;
  final DateTime creationTime;

  const Note({
    this.id,
    required this.body,
    required this.creationTime,
    required this.title,
  });

  Note copy({
    int? id,
    int? number,
    String? title,
    String? body,
    DateTime? creationTime,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        creationTime: creationTime ?? this.creationTime,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        body: json[NoteFields.body] as String,
        creationTime: DateTime.parse(json[NoteFields.creationTime] as String),
        title: json[NoteFields.title] as String,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.body: body,
        NoteFields.creationTime: creationTime.toIso8601String(),
      };
}
