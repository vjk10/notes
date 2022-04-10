const String tableNotes = 'NOTES';

class NoteFields {
  static final List<String> values = [
    id,
    title,
    body,
    creationTime,
    pinned,
    isList,
    totalItems
  ];
  static const String id = '_id';
  static const String title = '_title';
  static const String body = '_body';
  static const String creationTime = '_creationTime';
  static const String pinned = '_pinned';
  static const String isList = '_isList';
  static const String totalItems = '_totalItems';
}

class Note {
  final int? id;
  final String title;
  final String body;
  final String creationTime;
  final bool? pinned;
  final bool? isList;
  final int? totalItems;

  const Note(
      {this.id,
      required this.body,
      required this.creationTime,
      required this.title,
      this.pinned,
      this.isList,
      this.totalItems});

  Note copy(
          {int? id,
          int? number,
          String? title,
          String? body,
          String? creationTime,
          bool? pinned,
          bool? isList,
          int? totalItems}) =>
      Note(
          id: id ?? this.id,
          title: title ?? this.title,
          body: body ?? this.body,
          creationTime: creationTime ?? this.creationTime,
          pinned: pinned ?? this.pinned,
          isList: isList ?? this.isList,
          totalItems: totalItems ?? this.totalItems);

  static Note fromJson(Map<String, Object?> json) => Note(
      id: json[NoteFields.id] as int?,
      body: json[NoteFields.body] as String,
      creationTime: json[NoteFields.creationTime] as String,
      title: json[NoteFields.title] as String,
      pinned: json[NoteFields.pinned] as bool,
      isList: json[NoteFields.isList] as bool,
      totalItems: json[NoteFields.totalItems] as int);

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.body: body,
        NoteFields.creationTime: creationTime,
        NoteFields.pinned: pinned,
        NoteFields.isList: isList,
        NoteFields.totalItems: totalItems
      };
}
