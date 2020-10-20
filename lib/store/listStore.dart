import 'package:flutter/cupertino.dart';
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

  initLoad() async {
    isLoading = true;
    list = await fetchIndex();
    isLoading = false;
  }
}
