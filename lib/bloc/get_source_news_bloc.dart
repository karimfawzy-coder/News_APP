import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/app_states.dart';
import 'package:news_app/model/article.dart';

import 'package:news_app/repository/repository.dart';

class GetSourceNewsCubit extends Cubit<AppStates> {
  GetSourceNewsCubit() :super(AppInitialState());

 static GetSourceNewsCubit get(context) => BlocProvider.of(context);
  final NewsRepository _newsRepository = NewsRepository();

  List<ArticleModel> listOfArticles = [];
  getSourceNews(String sourceId) {
     _newsRepository.getSourceNews(sourceId).then((value) {
       listOfArticles =value.articles;
       emit(GetSourceNewsState());
     });

  }

}

//
// final NewsRepository _newsRepository = NewsRepository();
//
// BehaviorSubject<ArticleResponse> _subject = BehaviorSubject<ArticleResponse>();
//
// getSourceNews(String sourceId) async{
//   ArticleResponse response = await _newsRepository.getSourceNews(sourceId);
//   _subject.sink.add(response);
// }
//
// void drainStream(){
//   _subject.value = null;
// }
//
// @mustCallSuper
// void dispose()async{
//  await _subject.drain();
//  _subject.close();
