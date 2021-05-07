import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/app_states.dart';
import 'package:news_app/bloc/get_source_news_bloc.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/source.dart';
import 'package:news_app/style/theme.dart' as Style;
import 'package:timeago/timeago.dart' as timeago;

import 'news_details.dart';

class SourceDetails extends StatefulWidget {
  final SourceModel source;

  SourceDetails({Key key, this.source}) : super(key: key);

  @override
  _SourceDetailsState createState() => _SourceDetailsState();
}

class _SourceDetailsState extends State<SourceDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  GetSourceNewsCubit  getSourceNewsCubit = BlocProvider.of<GetSourceNewsCubit>(context , listen: false);
  getSourceNewsCubit.getSourceNews(widget.source.id);
    return  Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            elevation: 0,
            title: Text(''),
          ),
        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
              color: Style.Colors.mainColor,
              child: Column(
                children: [
                  Hero(
                    tag: widget.source.id,
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.white,
                          ),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/logos/${widget.source.id}.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.source.name,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.source.description,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            BlocBuilder<GetSourceNewsCubit, AppStates>(
              builder: (context, state) {
                return Expanded(
                    child: _buildSourceNews(getSourceNewsCubit.listOfArticles  ,  getSourceNewsCubit));
              },
            ),
          ],
        ),
    );
  }

  Widget _buildSourceNews(List<ArticleModel> articles , GetSourceNewsCubit  getSourceNewsCubit) {
    if (articles.length == 0) {
      return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "No more news",
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      );
    } else
      return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: getSourceNewsCubit,
                      child: NewsDetailsScreen(article: articles[index],),)));

              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey[200], width: 1.0),
                  ),
                  color: Colors.white,
                ),
                height: 150,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: 10.0, left: 10.0, bottom: 10.0, right: 10.0),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 3 / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Text(
                              articles[index].title,
                              maxLines: 3,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14.0)),
                          Expanded(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                            timeUntil(
                                                DateTime.parse(
                                                    articles[index].date)),
                                            style: TextStyle(
                                                color: Colors.black26,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10.0))
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 10.0),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 2 / 5,
                        height: 130,
                        child:
                        FadeInImage.assetNetwork(
                            imageErrorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                              return Icon(Icons.do_not_disturb);
                            },
                            alignment: Alignment.topCenter,
                            placeholder: 'assets/img/placeholder.jpg',
                            image: articles[index].image == null
                                ? null
                                : articles[index].image,
                            fit: BoxFit.fitHeight,
                            width: double.maxFinite,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 1 / 3))
                  ],
                ),
              ),
            );
          });
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}

