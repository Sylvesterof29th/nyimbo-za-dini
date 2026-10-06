import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/hymn.dart';

class HymnRepository {
  Future<List<Hymn>> getHymns() async {
    final jsonString = await rootBundle.loadString('assets/data/hymns.json');

    final List<dynamic> jsonData = jsonDecode(jsonString);

    return jsonData.map((json) => Hymn.fromJson(json)).toList();
  }
}
