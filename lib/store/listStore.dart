import 'package:mobx/mobx.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/services/api.dart';

part 'listStore.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store {
  @observable
  List<Pokemon> list = List<Pokemon>();

  @observable
  bool isLoading = false;

  int _offset = 40;
  int _limit = 15;

  initLoad() async {
    isLoading = true;
    list = await fetchIndex();
    isLoading = false;
  }

  fetchMore() async {
    isLoading = true;
    List<Pokemon> newList = await fetch(list, _offset, _limit);
    _offset += _limit;
    list = newList;
    isLoading = false;
  }
}
