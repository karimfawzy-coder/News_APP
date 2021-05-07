
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/app_states.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/article_response.dart';
import 'package:news_app/repository/repository.dart';


class GetHotNewsCubit extends Cubit<AppStates> {

  GetHotNewsCubit():super(AppInitialState());
  static GetHotNewsCubit get(context) => BlocProvider.of(context);
  final NewsRepository _newsRepository = NewsRepository();

  List<ArticleModel> hotNewsList = [];
   getHotNews()  {
     _newsRepository.getHotNews().then((value) {
       hotNewsList = value.articles;
       emit(GetHotNewsState());
     });
   }



}

// final getHotNewsBloc = GetHotNewsBloc();
//   final NewsRepository _newsRepository = NewsRepository();
//
//   // it`s like event
//   final BehaviorSubject<ArticleResponse> _subject = BehaviorSubject<ArticleResponse>();
//
//
//   getHotNews() async {
//     ArticleResponse response = await _newsRepository.getHotNews();
//     _subject.sink.add(response);
// }
// dispose(){
//     _subject?.close();
// }
//
//   BehaviorSubject<ArticleResponse> get subject => _subject;
