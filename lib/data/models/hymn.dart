import 'hymn_verse.dart';

class Hymn {
  final int id;
  final String number;
  final String title;
  final String category;
  final String language;
  final String? author;
  final String? composer;
  final List<HymnVerse> verses;

  const Hymn({
    required this.id,
    required this.number,
    required this.title,
    required this.category,
    required this.language,
    required this.verses,
    this.author,
    this.composer,
  });

  factory Hymn.fromJson(Map<String, dynamic> json) {
    return Hymn(
      id: json['id'] as int,
      number: json['number'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      language: json['language'] as String,
      author: json['author'] as String?,
      composer: json['composer'] as String?,
      verses: (json['verses'] as List)
          .map((verse) => HymnVerse.fromJson(verse as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'title': title,
      'category': category,
      'language': language,
      'author': author,
      'composer': composer,
      'verses': verses.map((verse) => verse.toJson()).toList(),
    };
  }
}
