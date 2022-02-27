class FolderFields {
  static final List<String> values = [
    id,
    title,
    description,
    creationTime,
  ];
  static const String id = '_id';
  static const String title = '_title';
  static const String description = '_description';
  static const String creationTime = '_creationTime';
}

class Folder {
  final int? id;
  final String title;
  final String description;
  final String creationTime;

  const Folder({
    this.id,
    required this.description,
    required this.creationTime,
    required this.title,
  });

  Folder copy({
    int? id,
    int? number,
    String? title,
    String? description,
    String? creationTime,
  }) =>
      Folder(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        creationTime: creationTime ?? this.creationTime,
      );

  static Folder fromJson(Map<String, Object?> json) => Folder(
        id: json[FolderFields.id] as int?,
        description: json[FolderFields.description] as String,
        creationTime: json[FolderFields.creationTime] as String,
        title: json[FolderFields.title] as String,
      );

  Map<String, Object?> toJson() => {
        FolderFields.id: id,
        FolderFields.title: title,
        FolderFields.description: description,
        FolderFields.creationTime: creationTime,
      };
}
