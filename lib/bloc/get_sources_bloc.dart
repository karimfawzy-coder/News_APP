import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/app_states.dart';
import 'package:news_app/model/article_response.dart';
import 'package:news_app/model/source.dart';
import 'package:news_app/model/source_response.dart';
import 'package:news_app/repository/repository.dart';


class GetSourcesCubit extends Cubit<AppStates>{

  GetSourcesCubit():super(AppInitialState());

  GetSourcesCubit get(context) => BlocProvider.of(context);
  final NewsRepository _newsRepository = NewsRepository();
 List<SourceModel> sources = [];
  getSources() {
    _newsRepository.getSources().then((value){
     sources = value.sources;
     print('build>>');
     emit(GetSourcesState(sources: value.sources));
    });
  }


}