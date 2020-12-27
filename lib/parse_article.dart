import 'dart:convert';
import 'package:routing/article.dart';

List<Article> parseArticles(String json){
    if(json == null){
      return [];
    }

    final List parsed = jsonDecode(json);
    return parsed.map((json) => Article.fromJson(json)).toList();
}
