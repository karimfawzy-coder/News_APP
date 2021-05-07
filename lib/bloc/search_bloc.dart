import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/app_states.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/article_response.dart';
import 'package:news_app/repository/repository.dart';

import 'events.dart';

class SearchCubit extends Cubit<AppStates>
{
  SearchCubit():super(AppInitialState());
  final NewsRepository _newsRepository = NewsRepository();
  static SearchCubit get(context) => BlocProvider.of(context);

  List<ArticleModel> articles=[];
  search(String searchValue){
    _newsRepository.search(searchValue).then((value){
      articles = value.articles;
      emit(SearchState());
    } );
  }


}