
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
    24448785, 24448784, 24448756, 24448738, 24448734, 24448727, 24448713, 24448710, 24448706, 24448705, 24448689, 24448678, 24448669, 24448657, 24448638, 24448633, 24448614, 24448562, 24448561, 24448551, 24448513, 24448474, 24448466, 24448464, 24448458, 24448455, 24448364
  ];

  List<int> _hottestIds = [
   24444497, 24445563, 24445603, 24446156, 24443128, 24440055, 24445067, 24441578, 24440163, 24444443, 24448281, 24441979, 24447274, 24447724, 24446569, 24434717, 24442294, 24447885, 24448466, 24441841, 24445936, 24446880, 24444276, 24446905, 24441377, 24441112, 24445886, 24447991, 24441392, 24440089, 24442731, 24447182, 24440516, 24444391, 24440536
  ];

  Sink<StoriesType> get storiesType  => _storiesTypeController.sink;
  Stream<UnmodifiableListView<Article>> get articles => _articleSubject.stream;
  Stream<bool> get isLoading => _isLoadingSubject.stream;

  HackerNewsBloc() {
    // TODO: fetch actual id's
    // TODO: find a way to cache the results until refresh
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