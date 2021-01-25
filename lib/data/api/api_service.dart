import 'dart:convert';

import 'package:routing/model/article.dart';

import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://newsapi.org/v2/';
  static final String _apiKey = 'bf1523f337d44d8abe08571b1779f9c6';
  static final String _category = 'business';
  static final String _country = 'id';

  Future<ArticleResult> topHeadlines() async {
    final response = await http.get(
        "${_baseUrl}top-headlines?country=$_country&category=$_category&apiKey=$_apiKey");

    if (response.statusCode == 200) {
      return ArticleResult.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
