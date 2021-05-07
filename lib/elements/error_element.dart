
import 'package:flutter/material.dart';

Widget buildErrorWidget(String error){
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center ,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(error,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold
        ),)
      ],
    ),
  );
}