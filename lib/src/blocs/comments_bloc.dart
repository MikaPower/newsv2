import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class CommentsBloc {
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  final  _repository = new Repository();

  //Stream getters
  Observable<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  //Sink getter
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream.transform(_commentsTransformer()).pipe(_commentsOutput);
  }

  _commentsTransformer(){
    //entra int, sai Map
    return ScanStreamTransformer<int, Map<int,Future<ItemModel>>>(
        (cache,int id, index){
              cache[id]= _repository.fetchItem(id);

              //after receiving future
              cache[id].then((ItemModel item){
                item.kids.forEach((kidId)=> fetchItemWithComments(kidId));

              });
        },
      <int, Future<ItemModel>>{}
    );
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
