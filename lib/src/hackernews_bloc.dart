
import 'dart:collection';

import 'package:rxdart/rxdart.dart';
import 'package:news_app/src/article.dart';
import 'package:news_app/hackernews_jsonparser.dart';
import 'package:http/http.dart' as http;

class HackerNewsBloc {
  final _articleSubject = BehaviorSubject<UnmodifiableListView<Article>>();
  var _articles = <Article>[];

  List<int> _ids = [
    24322861,
    24341535,
    24343672,
    24323589,
    24334731,
    24341867,
    24324974,
    24332412,
    24343361,
    24330326,
    24344045,
    24338152,
    24343572,
    24342540,
    24332485,
    24331698
  ];

  HackerNewsBloc() {
    _updateArticles().then((_) =>  {
      _articleSubject.add(UnmodifiableListView(_articles))
    });
  }

  Stream<UnmodifiableListView<Article>> get articles => _articleSubject.stream;


  Future<Article> _getArticle(int id) async {
    final itemEndpoint = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    var itemResponse = await http.get(itemEndpoint);

    if (itemResponse.statusCode == 200) {
      return parseArticle(itemResponse.body);
    }
    return Future.value(null);
  }

  Future<Null> _updateArticles() async {
    final futureArticles = await  _ids.map((id) => _getArticle(id));
    final articles = await Future.wait(futureArticles);
    _articles = articles;
  }
}