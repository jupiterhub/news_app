import 'package:flutter/material.dart';
import 'package:news_app/hackernews_jsonparser.dart';
import 'package:news_app/src/article.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Latest news'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  Future<Article> _getArticle(int id) async {
    final itemEndpoint = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    var itemResponse = await http.get(itemEndpoint);

    if (itemResponse.statusCode == 200) {
      return parseArticle(itemResponse.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children:
          _ids.map((id) =>
              FutureBuilder<Article>(
                future: _getArticle(id),
                builder: (BuildContext context,
                    AsyncSnapshot<Article> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildArticle(snapshot.data),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )).toList(),
        )
    );
  }

  Widget _buildArticle(Article article) {
    return Padding(
      key: Key(article.url),
      padding: const EdgeInsets.all(6.0),
      child: ExpansionTile(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${article.kids.length} comments"),
              IconButton(
                icon: Icon(Icons.launch),
                onPressed: () async {
                  _launchInWebViewWithJavaScript(article.url);
                },
              )
            ],
          )
        ],
        title: Text(
          article.title,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  Future<void> _launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
