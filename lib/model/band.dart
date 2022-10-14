import 'dart:convert';

class Band {
  final String name;
  final String genre;
  final String createdBy;

  Band({required this.name, required this.genre, required this.createdBy});

  Map<String, dynamic> toJson() => {
        'uid': createdBy,
        'name': name,
        'genre': genre,
      };

  static Band fromJson(Map<String, dynamic> jsonData) => Band(
      name: jsonData['name'],
      genre: jsonData['genre'],
      createdBy: jsonData['createdBy']);
}
