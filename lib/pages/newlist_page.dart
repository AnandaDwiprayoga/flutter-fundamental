import 'package:flutter/material.dart';
import 'package:routing/article.dart';
import 'package:routing/parse_article.dart';
import 'package:routing/widgets/build_article.dart';

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
                return buildArticleItem(context, articles[index]);
              },
            );
          },
        ),
    );
  }
}