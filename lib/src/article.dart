import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'article.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
      static Serializer<Article> get serializer => _$articleSerializer;

      int get id;
      @nullable
      bool get deleted;
      /// The type of article.
      ///
      /// Possible values are: "job", "story", "comment", "poll", or "pollopt".
      String get type;
      String get by;
      int get time;
      @nullable
      String get text;
      @nullable
      bool get dead;
      @nullable
      int get parent;
      @nullable
      int get poll;
      BuiltList<int> get kids;
      @nullable
      String get url;
      int get score;
      String get title;
      BuiltList<int> get parts;
      @nullable
      int get descendants;

  Article._();
  factory Article([void Function(ArticleBuilder) updates]) = _$Article;
}