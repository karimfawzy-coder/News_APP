import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/app_states.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/article_response.dart';
import 'package:news_app/repository/repository.dart';

import 'events.dart';

class GetTopHeadLineCubit extends Cubit<AppStates>{

  GetTopHeadLineCubit() : super(AppInitialState());

 static GetTopHeadLineCubit get(context) => BlocProvider.of(context);

  final NewsRepository _newsRepository = NewsRepository();
  List<ArticleModel> articles = [];
  getTopHeadlines() {
    _newsRepository.getTopHeadlines().then((value) {
      articles = value.articles;
     emit(GetTopHeadLineStateState(articles: value.articles));
    });
  }

  // @override
  // Stream<AppStates> mapEventToState(HeadLineEvents event) async* {
  //   switch (event) {
  //     case HeadLineEvents.DONE:
  //       yield GetTopHeadLineStateState(articles: articles);
  //       break;
  //   }
  // }
}