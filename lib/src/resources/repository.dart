import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
List<Source> sources = <Source>[
 newsDbProvider,
  newsApiProvider(),
];

List<Cache> caches = <Cache>[
  newsDbProvider
];
//To do iterate over sources
  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  /// Buscar item na base de dados
  /// se nao tiver ai há api e guardar na base de dados
  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;
    for (source in sources) {
      item = await source.fetchItem(id);
      if(item!=null){
        break;
      }
    }
    for(var cache in caches) {
      if (cache != source) {
        cache.addItem(item);
      }
    }
    return item;
  }

}



abstract class Source {
  Future<List<int>>fetchTopIds();
  Future<ItemModel>fetchItem(int id);
}

abstract class Cache {
 Future<int> addItem(ItemModel item);

}
