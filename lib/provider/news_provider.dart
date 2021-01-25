import 'package:flutter/material.dart';
import 'package:routing/data/api/api_service.dart';
import 'package:routing/model/article.dart';

enum ResultState { Loading, NoData, HasData, Error }

class NewsProvider extends ChangeNotifier {
  final ApiService apiService;

  NewsProvider({@required this.apiService}) {
    _fetchAllArtilce();
  }

  ArticleResult _articleResult;
  String _message = '';
  ResultState _state;

  String get message => _message;
  ArticleResult get result => _articleResult;
  ResultState get state => _state;

  Future<dynamic> _fetchAllArtilce() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final article = await apiService.topHeadlines();
      if (article.articles.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _articleResult = article;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
