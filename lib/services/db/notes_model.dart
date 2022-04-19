const String tableNotes = 'NOTES';

class NoteFields {
  static final List<String> values = [
    id,
    title,
    body,
    creationTime,
    pinned,
    isList,
    isExpense,
    totalItems,
    type
  ];
  static const String id = '_id';
  static const String title = '_title';
  static const String body = '_body';
  static const String creationTime = '_creationTime';
  static const String pinned = '_pinned';
  static const String isList = '_isList';
  static const String isExpense = '_isExpense';
  static const String totalItems = '_totalItems';
  static const String type = '_type';
}

class Note {
  final int? id;
  final String title;
  final String body;
  final String creationTime;
  final bool? pinned;
  final bool? isList;
  final bool? isExpense;
  final int? totalItems;
  final String type;

  const Note({
    this.id,
    required this.body,
    required this.creationTime,
    required this.title,
    this.pinned,
    this.isList,
    this.isExpense,
    this.totalItems,
    required this.type,
  });

  Note copy({
    int? id,
    int? number,
    String? title,
    String? body,
    String? creationTime,
    bool? pinned,
    bool? isList,
    bool? isExpense,
    int? totalItems,
    String? type,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        creationTime: creationTime ?? this.creationTime,
        pinned: pinned ?? this.pinned,
        isList: isList ?? this.isList,
        isExpense: isExpense ?? this.isExpense,
        totalItems: totalItems ?? this.totalItems,
        type: this.type,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        body: json[NoteFields.body] as String,
        creationTime: json[NoteFields.creationTime] as String,
        title: json[NoteFields.title] as String,
        pinned: json[NoteFields.pinned] as bool,
        isList: json[NoteFields.isList] as bool,
        isExpense: json[NoteFields.isExpense] as bool,
        totalItems: json[NoteFields.totalItems] as int,
        type: json[NoteFields.type] as String,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.body: body,
        NoteFields.creationTime: creationTime,
        NoteFields.pinned: pinned,
        NoteFields.isList: isList,
        NoteFields.isExpense: isExpense,
        NoteFields.totalItems: totalItems
      };
}
