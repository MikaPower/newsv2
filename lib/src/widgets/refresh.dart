import 'package:flutter/material.dart';

class Refresh extends StatelessWidget{
  final Widget child;


    Refresh({this.child});


  Widget build(BuildContext context) {
        return new RefreshIndicator(
        child: child,
          onRefresh: (){

          },
        );
  }

}