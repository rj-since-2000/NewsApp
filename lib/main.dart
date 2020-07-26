import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newsapp/content.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'News App'),
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
  int tabIndex = 0;

  Future<Map<String, dynamic>> getData(String url) async {
    http.Response response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json",
      },
    );
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Widget page(String url) {
    return FutureBuilder(
      future: getData(url),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemBuilder: (ctx, index) => Content(
              futureSnapshot.data['articles'][index]['source']['name'],
              futureSnapshot.data['articles'][index]['author'],
              futureSnapshot.data['articles'][index]['title'],
              futureSnapshot.data['articles'][index]['description'],
              futureSnapshot.data['articles'][index]['url'],
              futureSnapshot.data['articles'][index]['urlToImage'],
              futureSnapshot.data['articles'][index]['publishedAt']),
          itemCount: futureSnapshot.data['articles'].length,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 10,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {});
                  })
            ],
            bottom: TabBar(isScrollable: true, labelColor: Colors.white, tabs: [
              Tab(
                text: 'Bitcoin',
              ),
              Tab(
                text: 'Business',
              ),
              Tab(
                text: 'Apple',
              ),
              Tab(
                text: 'TechCrunch',
              ),
              Tab(
                text: 'Wall Street',
              ),
              Tab(
                text: 'BBC news',
              ),
              Tab(
                text: 'Entertainment',
              ),
              Tab(
                text: 'Science',
              ),
              Tab(
                text: 'Health',
              ),
              Tab(
                text: 'Sports',
              ),
            ]),
            title: Text(
              widget.title,
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: TabBarView(
            children: [
              page(
                  "http://newsapi.org/v2/everything?q=bitcoin&from=2020-06-26&sortBy=publishedAt&apiKey=b864c8b786ad4f92a989a8cf154aef10"),
              page(
                  "http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=b864c8b786ad4f92a989a8cf154aef10"),
              page(
                  "http://newsapi.org/v2/everything?q=apple&from=2020-07-25&to=2020-07-25&sortBy=popularity&apiKey=b864c8b786ad4f92a989a8cf154aef10"),
              page(
                  "http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=b864c8b786ad4f92a989a8cf154aef10"),
              page(
                  "http://newsapi.org/v2/everything?domains=wsj.com&apiKey=b864c8b786ad4f92a989a8cf154aef10"),
              page(
                  "http://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=b864c8b786ad4f92a989a8cf154aef10"),
              page(
                  "http://newsapi.org/v2/top-headlines?country=in&category=entertainment&apiKey=b864c8b786ad4f92a989a8cf154aef10"),
              page(
                  "http://newsapi.org/v2/top-headlines?country=in&category=science&apiKey=b864c8b786ad4f92a989a8cf154aef10"),
              page(
                  "http://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=b864c8b786ad4f92a989a8cf154aef10"),
              page(
                  "http://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=b864c8b786ad4f92a989a8cf154aef10"),
            ],
          ),
        ),
      ),
    );
  }
}
