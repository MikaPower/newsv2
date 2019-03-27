import 'package:flutter/material.dart';
import 'package:news/src/models/item_model.dart';
import '../blocs/comments_provider.dart';

class NewsDetail extends StatelessWidget {


  final int itemId;

  NewsDetail({this.itemId});


  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Detail'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot <Map<int, Future<ItemModel>>>snapshot) {
        if (!snapshot.hasData) {
          return new Text('Loading');
        }
        final itemFuture = snapshot.data[itemId];

        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel>itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return new Text('Loading');
            }
            return buildTitle(itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTitle(ItemModel item) {
    return new Container(
      alignment: Alignment.topCenter ,
      margin: new EdgeInsets.all(10.0),
      child: new Text(item.title,
        textAlign: TextAlign.center,
      style: new TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),),
    );
  }
}