import 'package:flutter/material.dart';
import 'package:routing/article.dart';
import 'package:routing/pages/detail_page.dart';

Widget buildArticleItem(BuildContext context, Article article) {
    return ListTile(
      onTap: () => Navigator.pushNamed(context, ArticleDetailPage.routeName,arguments: article),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
        tag: article.urlToImage,
        child: Image.network(
          article.urlToImage,
          width: 100,
        ),
      ),
      title: Text(article.title),
      subtitle: Text(article.author),
    );
}