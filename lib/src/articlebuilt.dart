import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'articlebuilt.g.dart';

abstract class ArticleBuilt implements Built<ArticleBuilt, ArticleBuiltBuilder> {
  int get id;
  bool get deleted;
  String get type; // "job", "story", "comment", "poll", or "pollopt".
  String get by;
  int get time;
  String get text;
  bool get dead;
  int get parent;
  int get poll;
  BuiltList<int> get kids;
  String get url;
  int get score;
  String get title;
  BuiltList<int> get parts;
  int get descendants;

  ArticleBuilt._();
  factory ArticleBuilt([void Function(ArticleBuiltBuilder) updates]) = _$ArticleBuilt;
}