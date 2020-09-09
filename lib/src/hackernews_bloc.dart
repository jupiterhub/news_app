
import 'dart:async';
import 'dart:collection';

import 'package:rxdart/rxdart.dart';
import 'package:news_app/src/article.dart';
import 'package:news_app/hackernews_jsonparser.dart';
import 'package:http/http.dart' as http;

enum StoriesType {
  hottest,
  latest
}

class HackerNewsBloc {
  final _articleSubject = BehaviorSubject<UnmodifiableListView<Article>>();
  final _isLoadingSubject = BehaviorSubject<bool>();
  var _articles = <Article>[];

  final _storiesTypeController = StreamController<StoriesType>();

  List<int> _latestIds = [
    24322861,
    24341535,
    24343672,
    24323589,
    24334731,
    24341867,
    24324974,
    24332412,
  ];

  List<int> _hottestIds = [
    24343361,
    24330326,
    24344045,
    24338152,
    24343572,
    24342540,
    24332485,
    24331698,
  ];

  Sink<StoriesType> get storiesType  => _storiesTypeController.sink;
  Stream<UnmodifiableListView<Article>> get articles => _articleSubject.stream;
  Stream<bool> get isLoading => _isLoadingSubject.stream;

  HackerNewsBloc() {
    getArticlesAndAddToSubject(_latestIds);

    _storiesTypeController.stream.listen((storiesType) {
      if (storiesType == StoriesType.hottest) {
        getArticlesAndAddToSubject(_hottestIds);
      } else if (storiesType == StoriesType.latest) {
        getArticlesAndAddToSubject(_latestIds);
      } else {
        throw UnsupportedError("Unsupported story type");
      }
    });
  }
  getArticlesAndAddToSubject(List<int> ids)  async {
    _isLoadingSubject.add(false);
    await _updateArticles(ids).then((_) => _articleSubject.add(UnmodifiableListView(_articles)));
    _isLoadingSubject.add(true);
  }



  Future<Article> _getArticle(int id) async {
    final itemEndpoint = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    var itemResponse = await http.get(itemEndpoint);

    if (itemResponse.statusCode == 200) {
      return parseArticle(itemResponse.body);
    }
    return Future.value(null);
  }

  Future<Null> _updateArticles(List<int> ids) async {
    final futureArticles = ids.map((id) => _getArticle(id));
    final articles = await Future.wait(futureArticles);
    _articles = articles;
  }
}