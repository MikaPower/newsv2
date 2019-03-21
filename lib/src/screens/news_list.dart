import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_bloc.dart';
import 'dart:async';
import '../blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  Widget build(context) {
    final bloc = StoriesProvider.of(context);
    //this is bad
    bloc.fetchTopIds();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("TopbuildList"),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
        stream: bloc.topIds,
        builder: (context, AsyncSnapshot<List<int>>snapshot) {
          if (!snapshot.hasData) {
            return new Center(
              child: new CircularProgressIndicator(),
            );

          }
          return new ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              return new Text('${snapshot.data[index]}');
            },
          );
        }
    );
  }
}

