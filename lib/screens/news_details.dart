import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/style/theme.dart' as Style;
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatefulWidget {
  final ArticleModel article;

  NewsDetailsScreen({this.article});

  @override
  _NewsDetailsScreenState createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: (){
          launch(widget.article.url);
        },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 48,
        color: Style.Colors.mainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Read More',style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),)
          ],
        ),
      ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Style.Colors.mainColor,
        title: Text(
          widget.article.title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/img/placeholder.jpg',
              image: widget.article.image,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Text(widget.article.date.substring(0,10),style: TextStyle(
                  color: Style.Colors.mainColor,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 10,),
                Text(widget.article.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),),
                SizedBox(height: 10,),
                Html(data: widget.article.content,
                  renderNewlines: true,
                  defaultTextStyle: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black87)),

              ],
            ),
          )
        ],
      ),
    );
  }
}
