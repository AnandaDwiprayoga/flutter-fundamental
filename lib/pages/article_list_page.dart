import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routing/data/api/api_service.dart';
import 'package:routing/model/article.dart';
import 'package:routing/pages/detail_page.dart';
import 'package:routing/provider/news_provider.dart';
import 'package:routing/widgets/card_article.dart';
import 'package:routing/widgets/platform_widget.dart';

class ArticleListPage extends StatefulWidget {
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  Future<ArticleResult> _article;

  @override
  void initState() {
    _article = ApiService().topHeadlines();
    super.initState();
  }

  Widget _buildList(BuildContext context) {
    return Consumer<NewsProvider>(
      //defaultassetbundle akan membaca string dari berkas asset local
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.articles.length,
            itemBuilder: (context, index) {
              // return buildArticleItem(context, articles[index]);
              var article = state.result.articles[index];
              return CardArticle(
                article: article,
                onPressed: () => Navigator.pushNamed(
                  context,
                  ArticleDetailPage.routeName,
                  arguments: article,
                ),
              );
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
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
