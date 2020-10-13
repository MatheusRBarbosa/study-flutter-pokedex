import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pokedex/models/Pokemon.dart';
import '../services/api.dart';

class ListController extends GetxController {
  var list = List<Pokemon>().obs;
  int _offset = 40;
  int _limit = 15;

  @override
  void onInit() {
    _initLoad();
    super.onInit();
  }

  _initLoad() async {
    list.value = await fetchIndex();
    debugPrint("Fetch inicial concluido");
  }

  fetchMore() async {
    List<Pokemon> newList = await fetch(list, _offset, _limit);
    _offset += _limit;
    list = newList;
  }
}
