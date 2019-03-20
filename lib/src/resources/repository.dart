import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
  newsApiProvider apiProvider = newsApiProvider();

  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  /// Buscar item na base de dados
  /// se nao tiver ai há api e guardar na base de dados
  Future <ItemModel> fetchItem(int id) async {
    var item = await dbProvider.fetchItem(id);
    if (item != null) {
      return item;
    }

    item = await apiProvider.fetchItem(id);
    dbProvider.addItem(item);
    return item;
  }
}
