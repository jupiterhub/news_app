import 'package:built_value/built_value.dart';

part 'articlebuilt.g.dart';

abstract class ArticleBuilt implements Built<ArticleBuilt, ArticleBuiltBuilder> {
  int get id;

  ArticleBuilt._();
  factory ArticleBuilt([void Function(ArticleBuiltBuilder) updates]) = _$ArticleBuilt;
}