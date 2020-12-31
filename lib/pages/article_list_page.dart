import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routing/model/article.dart';
import 'package:routing/parse_article.dart';
import 'package:routing/widgets/build_article.dart';
import 'package:routing/widgets/platform_widget.dart';

class ArticleListPage extends StatelessWidget {

  Widget _buildList(BuildContext context) {
      return FutureBuilder<String>(
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
      );
  }

  Widget _buildAndroid(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context){
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}