import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget{
  final int itemId;
  NewsDetail({this.itemId});



  Widget build(BuildContext context){
 return new Scaffold(
   appBar: new AppBar(
     title: new Text('Detail'),
   ),
   body: new Text("$itemId"),
 );
  }
}