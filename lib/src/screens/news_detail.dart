import 'package:flutter/material.dart';
import 'package:news/src/models/item_model.dart';
import '../blocs/comments_provider.dart';
import '../widgets/comment.dart';

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
          return new Text('Loading 2');
        }
        final itemFuture = snapshot.data[itemId];

        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel>itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return new Text('Loading');
            }
            return buildList(itemSnapshot.data,snapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map <int,Future<ItemModel>> itemMap) {
    final children = <Widget> [];
    children.add(buildTitle(item));
    final commentsList = item.kids.map((kidId){
      return Comment(
        itemId: kidId,
        itemMap: itemMap,
      );

    }).toList();
    children.addAll(commentsList);
      return new ListView(
        children: children
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