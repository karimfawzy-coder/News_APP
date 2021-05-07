import 'package:news_app/model/article.dart';

class ArticleResponse {
  final List<ArticleModel> articles;
  final String error;

  ArticleResponse({this.articles, this.error});

  ArticleResponse.fromJson(Map<String, dynamic> json)
      : articles = (json['articles'] as List).map((articleItem) =>
      ArticleModel.fromJson(articleItem)).toList(),
        error = '';

  ArticleResponse.whileError(String errorValue)
      : articles = [],
        error = errorValue;

}