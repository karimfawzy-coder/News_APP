import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/app_states.dart';
import 'package:news_app/bloc/get_topheadline_bloc.dart';
import 'package:news_app/screens/news_details.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:news_app/model/article.dart';

class HeadLineSlider extends StatefulWidget {
  @override
  _HeadLineSliderState createState() => _HeadLineSliderState();
}

class _HeadLineSliderState extends State<HeadLineSlider> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetTopHeadLineCubit>(context, listen: false)
        .getTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTopHeadLineCubit, AppStates>(
        builder: (context, state) {
      final headLineCubit = GetTopHeadLineCubit.get(context);
      return ConditionalBuilder(
        condition: headLineCubit.articles.length > 0,
        fallback: (context) => Center(
          child: CircularProgressIndicator(),
        ),
        builder: (context) => _buildHeadlineSlider(headLineCubit.articles , headLineCubit),
      );
    });
  }

  Widget _buildHeadlineSlider(List<ArticleModel> articles , GetTopHeadLineCubit headLineCubit) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
            enlargeCenterPage: false, height: 200, viewportFraction: 0.9),
        items: getItemsSliders(articles,headLineCubit),
      ),
    );
  }

  getItemsSliders(List<ArticleModel> articles , GetTopHeadLineCubit headLineCubit) {
    return articles.map((item) {
      return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: headLineCubit,
                child: NewsDetailsScreen(article: item,),)));
        },
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: item.image == null
                        ? AssetImage('assets/img/placeholder.jpg')
                        : NetworkImage(item.image),
                  ),
                ),
                // child: FadeInImage(
                //   placeholder: AssetImage('assets/img/placeholder.jpg'),
                //   fit: BoxFit.fill,
                //   image: NetworkImage(item.image),
                // ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.1, 0.9],
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.white.withOpacity(0.0),
                      ],
                    )),
              ),
              Positioned(
                bottom: 40,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: 250,
                  child: Column(
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                            height: 1.5,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Text(
                  item.source.name,
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Text(
                  timeAgo(DateTime.parse(item.date)),
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  String timeAgo(DateTime dateTime) {
    return timeago.format(dateTime, allowFromNow: true, locale: 'en');
  }
}
