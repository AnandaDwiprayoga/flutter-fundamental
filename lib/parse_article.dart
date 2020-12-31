import 'dart:convert';
import 'package:routing/model/article.dart';

List<Article> parseArticles(String json){
    if(json == null){
      return [];
    }

    final List parsed = jsonDecode(json);
    return parsed.map((json) => Article.fromJson(json)).toList();
}
