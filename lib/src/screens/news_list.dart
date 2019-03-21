import 'package:flutter/material.dart';

class NewsList extends StatelessWidget{
  Widget build (context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Top news"),
      ),
      body: new Text('Show some news here!')
    );
  }
}