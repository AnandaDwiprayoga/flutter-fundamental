import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:routing/article.dart';
import 'package:routing/detail_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Route',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      //jika menggunakan initialRoute tidak bisa menggunakan parameter home
      initialRoute: NewsListPage.routeName,
      routes: {
        NewsListPage.routeName: (context) => NewsListPage(),
        ArticleDetailPage.routeName: (context) => ArticleDetailPage(article: ModalRoute.of(context).settings.arguments)
      },
    );
  }
}


class NewsListPage extends StatelessWidget {
  static const routeName = '/article_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('News App'),
        ),
        body: FutureBuilder<String>(
          //defaultassetbundle akan membaca string dari berkas asset local
          future: DefaultAssetBundle.of(context).loadString('assets/articles.json'),
          builder: (context, snapsot){
            final List<Article> articles = parseArticles(snapsot.data);
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index){
                return _buildArticleItem(context, articles[index]);
              },
            );
          },
        ),
    );
  }
}

Widget _buildArticleItem(BuildContext context, Article article) {
    return ListTile(
      onTap: () => Navigator.pushNamed(context, ArticleDetailPage.routeName,arguments: article),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
        article.urlToImage,
        width: 100,
      ),
      title: Text(article.title),
      subtitle: Text(article.author),
    );
}


List<Article> parseArticles(String json){
    if(json == null){
      return [];
    }

    final List parsed = jsonDecode(json);
    return parsed.map((json) => Article.fromJson(json)).toList();
}
