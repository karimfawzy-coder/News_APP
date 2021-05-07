import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/get_hotnews_bloc.dart';
import 'package:news_app/bloc/get_source_news_bloc.dart';
import 'package:news_app/bloc/get_sources_bloc.dart';
import 'package:news_app/bloc/get_topheadline_bloc.dart';
import 'package:news_app/widgets/headline_slider.dart';
import 'package:news_app/widgets/hot_news.dart';
import 'package:news_app/widgets/top_channels.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> GetTopHeadLineCubit()),
        BlocProvider(create: (context) => GetSourcesCubit()),
        BlocProvider(create: (context)=> GetHotNewsCubit()),
        BlocProvider(create: (context) => GetSourceNewsCubit()),
      ],
      child: ListView(
        children: [
          HeadLineSlider(),
          Padding(padding: EdgeInsets.all(10),
          child: Text(
            'Top Channels',
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.bold
            ),
          ),),
          TopChannels(),
          Padding(padding: EdgeInsets.all(10),
            child: Text(
              'Hot News',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold
              ),
            ),),
          HotNews(),

        ],
      ),
    );
  }
}
