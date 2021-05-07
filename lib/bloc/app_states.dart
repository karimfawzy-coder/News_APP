

import 'package:news_app/model/article.dart';
import 'package:news_app/model/source.dart';

abstract class AppStates {}


class AppInitialState extends AppStates{}
class ChangeBottomNavBar extends AppStates{
}
class ShowHome  extends ChangeBottomNavBar{
  final int itemIndex = 0;

}
class ShowSources extends ChangeBottomNavBar{
  final int itemIndex = 1;

}
class ShowSearch extends ChangeBottomNavBar{
  final int itemIndex = 2;

}

class GetTopHeadLineStateState extends AppStates{
  List<ArticleModel> articles = [];

  GetTopHeadLineStateState({this.articles});
}

class GetHotNewsState extends AppStates{}
class GetSourceNewsState extends AppStates{}
class GetSourcesState extends AppStates{
  List<SourceModel> sources = [];

  GetSourcesState({this.sources});
}
class SearchState extends AppStates{}
class SearchChanged extends AppStates{}


class AppLoadingState extends AppStates{}
