class HymnVerse {
  final int verseNumber;
  final List<String> lines;

  const HymnVerse({required this.verseNumber, required this.lines});

  factory HymnVerse.fromJson(Map<String, dynamic> json) {
    return HymnVerse(
      verseNumber: json['verse'] as int,
      lines: List<String>.from(json['lines'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {'verse': verseNumber, 'lines': lines};
  }
}
