import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:news_app/src/article.dart';
import 'package:news_app/src/hackernews_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  final hackerNewsBloc = HackerNewsBloc();

  runApp(MyApp(bloc: hackerNewsBloc));
}

class MyApp extends StatelessWidget {
  final HackerNewsBloc bloc;

  MyApp({Key key, this.bloc}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Hacker news', bloc: bloc),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final HackerNewsBloc bloc;
  final String title;


  MyHomePage({Key key, this.title, this.bloc}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int navigationIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: LoadingInfo(bloc: widget.bloc),
      ),
      body: StreamBuilder<UnmodifiableListView<Article>>(
          stream: widget.bloc.articles,
          initialData: UnmodifiableListView<Article>([]),
          builder:  (context, snapshot) => ListView(
              children: snapshot.data.map((x) => _buildArticle(x)).toList(),
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationIndex,
        onTap: (index) {
          if (index == 0) {
            widget.bloc.storiesType.add(StoriesType.hottest);
          } else {
            widget.bloc.storiesType.add(StoriesType.latest);
          }
          setState(() {
            navigationIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Top stories'),
            icon: Icon(Icons.whatshot)
          ),
          BottomNavigationBarItem(
            title: Text('Latest stories'),
            icon: Icon(Icons.fiber_new)
          ),
        ],
      ),
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

class LoadingInfo extends StatelessWidget {
  final HackerNewsBloc bloc;

  LoadingInfo({Key key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.isLoading,
      builder: (context, snapshot) => snapshot.hasData && !snapshot.data ? CircularProgressIndicator(backgroundColor: Colors.white, strokeWidth: 1,) : FaIcon(FontAwesomeIcons.hackerNews, size: 50,),
    );
  }
}

