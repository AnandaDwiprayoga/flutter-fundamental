import 'package:flutter/material.dart';
import 'package:routing/pages/detail_page.dart';
import 'package:routing/pages/newlist_page.dart';
import 'package:routing/style.dart';

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
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        textTheme: myTextTheme,
        appBarTheme: AppBarTheme(
          textTheme: myTextTheme.apply(bodyColor: Colors.black),
          elevation: 0
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: secondaryColor,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))
          )
        ),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      //jika menggunakan initialRoute tidak bisa menggunakan parameter home
      initialRoute: NewsListPage.routeName,
      routes: {
        NewsListPage.routeName: (context) => NewsListPage(),
        ArticleDetailPage.routeName: (context) => ArticleDetailPage(article: ModalRoute.of(context).settings.arguments),
        ArticleWebView.routeName : (context) => ArticleWebView(url: ModalRoute.of(context).settings.arguments)
      },
    );
  }
}







