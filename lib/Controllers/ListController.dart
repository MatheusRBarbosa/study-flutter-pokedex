import 'package:get/get.dart';
import 'package:pokedex/models/Pokemon.dart';
import '../services/api.dart';

class ListController extends GetxController {
  var list = List<Pokemon>().obs;
  RxBool isLoading = false.obs;
  int _offset = 40;
  int _limit = 15;

  @override
  void onInit() {
    _initLoad();
    super.onInit();
  }

  _initLoad() async {
    isLoading.value = true;
    list.value = await fetchIndex();
    isLoading.value = false;
  }

  fetchMore() async {
    isLoading.value = true;
    List<Pokemon> newList = await fetch(list, _offset, _limit);
    _offset += _limit;
    list = newList;
    isLoading.value = false;
  }
}
