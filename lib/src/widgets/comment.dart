import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';


class Comment extends StatelessWidget{
  final int itemId;
  final Map<int,Future<ItemModel>> itemMap;


  Comment({this.itemId,this.itemMap});

  Widget build(BuildContext context) {
     return FutureBuilder(
       future: itemMap[itemId],
       builder: (context,AsyncSnapshot  <ItemModel> snapshot){

         if(!snapshot.hasData){
           return new Text('Still loading comment');
         }
         final children = <Widget>[
           new Text(snapshot.data.text),
         ];

         snapshot.data.kids.forEach((kidId){
          children.add(Comment(
             itemId: kidId,
             itemMap: itemMap,
           ),);
         });

         return new Column(
           children: children,
         );
         
       },
     );
  }

}