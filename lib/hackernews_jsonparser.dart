import 'dart:convert';

import 'package:news_app/src/article.dart';

List<int> parseStories(String jsonStr) {
  List<dynamic> json = jsonDecode(jsonStr);
  return json.cast<int>();
}

Article parseArticle(String jsonStr) {
  Map<String, dynamic> json = jsonDecode(jsonStr);
  return Article.fromJson(json);
}
