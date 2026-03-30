class DiaryEntry {
  final int? id;
  final String? title;
  final String content;
  final DateTime createdAt;

  const DiaryEntry({
    this.id,
    this.title,
    required this.content,
    required this.createdAt,
  });

  DiaryEntry copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
  }) {
    return DiaryEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
