import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_app/model/article_response.dart';
import 'package:news_app/model/source_response.dart';
class NewsRepository {
  static String mainUrl = 'https://newsapi.org/v2/';
  final String apiKey = '7c6126b40cab454f981774ae8587088f';

  final Dio _dio = Dio();

  // api end points
  var getSourcesUrl = '$mainUrl/sources';
  var topHeadlines = '$mainUrl/top-headlines';
  var getEverythingUrl = '$mainUrl/everything';

  Future<SourceResponse> getSources() async {
    var parameters = {'apiKey': apiKey, 'language': 'en', 'country': 'us'};
    Response response =
    await _dio.get(getSourcesUrl, queryParameters: parameters);
    try {
      return SourceResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw DioError(
        response: response,
        error: 'Http status error [${response.statusCode}]',
        type: DioErrorType.RESPONSE,
      );
      return SourceResponse.withError(error);
    }
    return null;
  }

  Future<ArticleResponse> getTopHeadlines() async {
    var params = {
      "apiKey": apiKey,
      "country": "us"};
    Response response = await _dio.get(topHeadlines, queryParameters: params);
    try {
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      throw DioError(
        response: response,
        error: 'Http status error [${response.statusCode}]',
        type: DioErrorType.RESPONSE,
      );
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.whileError("$error");
    }
  }

  Future<ArticleResponse> getHotNews() async {
    var parameters = {
      'apiKey': apiKey,
      'q': 'apple',
      'sortBy': 'popularity',
    };
    final Response response =
        await _dio.get(getEverythingUrl, queryParameters: parameters);
    try {
      return ArticleResponse.fromJson(response.data);
    } catch (error) {
      throw DioError(
        response: response,
        error: 'Http status error [${response.statusCode}]',
        type: DioErrorType.RESPONSE,
      );
      return ArticleResponse.whileError(error);
    }
  }

  Future<ArticleResponse> getSourceNews(String sourceId) async {
    var parameters = {
      'apiKey': apiKey,
      'sources': sourceId,
    };
    final Response response =
        await _dio.get(topHeadlines, queryParameters: parameters);
    try {
      return ArticleResponse.fromJson(response.data);
    } catch (error) {
      throw DioError(
        response: response,
        error: 'Http status error [${response.statusCode}]',
        type: DioErrorType.RESPONSE,
      );
      return ArticleResponse.whileError(error);
    }
  }

  Future<ArticleResponse> search(String searchValue) async {
      var parameters = {
        'apiKey': apiKey,
        'q': searchValue,
        "sortBy": "popularity"
      };
      final Response response =
          await _dio.get(topHeadlines, queryParameters: parameters);
      try {
        return ArticleResponse.fromJson(response.data);
      } catch (error) {
        DioError assureDioError(err, [RequestOptions requestOptions]) {
          DioError dioError;
          if (err is DioError) {
            dioError = err;
          } else {
            dioError = DioError(error: err);
          }
          dioError.request = dioError.request ?? requestOptions;
          return dioError;
        }
        throw assureDioError(error);

        return ArticleResponse.whileError(error);
      }
    }

  }

