class PlaystoreData {
  final String version;
  final String recentChanges;
  final String icon;

  const PlaystoreData({
    required this.version,
    required this.recentChanges,
    required this.icon,
  });

  factory PlaystoreData.fromJson(Map<String, dynamic> json) {
    return PlaystoreData(
      version: json['version'],
      recentChanges: json['recentChanges'],
      icon: json['icon'],
    );
  }
}
