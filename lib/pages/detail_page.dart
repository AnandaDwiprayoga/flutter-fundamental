import 'package:flutter/material.dart';
import 'package:routing/model/article.dart';
import 'package:routing/widgets/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final Article article;

  const ArticleDetailPage({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            article.urlToImage == null
                ? Container(
                    height: 200,
                    child: Icon(
                      Icons.error,
                    ),
                  )
                : Hero(
                    tag: article.urlToImage,
                    child: Image.network(article.urlToImage)),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.description ?? "",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Divider(color: Colors.grey),
                  Text(
                    article.title ?? "",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  Divider(color: Colors.grey),
                  Text('Date: ${article.publishedAt}'),
                  SizedBox(height: 10),
                  Text('Author: ${article.author}'),
                  Divider(color: Colors.grey),
                  Text(article.content ?? "", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ArticleWebView.routeName,
                          arguments: article.url);
                    },
                    child: Text('Read more'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ArticleWebView extends StatelessWidget {
  static const routeName = '/article_web';

  final String url;

  const ArticleWebView({@required this.url});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: WebView(
        initialUrl: url,
        //to enable javascript code in webview
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
