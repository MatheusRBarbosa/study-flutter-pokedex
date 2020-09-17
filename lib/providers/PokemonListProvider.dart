import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../services/api.dart';

import '../models/Pokemon.dart';

class PokemonListProvider extends ChangeNotifier {
  List<Pokemon> _list = [];
  int _offset = 40;
  int _limit = 15;

  List<Pokemon> get list => _list;

  PokemonListProvider() {
    _initLoad();
  }

  _initLoad() async {
    _list = await fetchIndex();
    notifyListeners();
  }

  fetchMore() async {
    List<Pokemon> newList = await fetch(_list, _offset, _limit);
    _offset += _limit;
    _list = newList;
    notifyListeners();
  }
}
