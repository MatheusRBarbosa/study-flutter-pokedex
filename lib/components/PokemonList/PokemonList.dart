import 'package:flutter/material.dart';
import 'package:pokedex/components/PokemonList/PokemonCardList.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/screens/PokemonDetails.dart';
import 'package:get/get.dart';
import 'package:pokedex/Controllers/ListController.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonList createState() => _PokemonList();
}

class _PokemonList extends State<PokemonList> {
  ScrollController _scrollController = new ScrollController();
  final ListController listController = Get.put(ListController());

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _setupScrollListener();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      double trigger = 0.8 * _scrollController.position.maxScrollExtent;

      if (_scrollController.offset >= trigger &&
          !listController.isLoading.value) {
        debugPrint("CARREGANDO MAIS POKEMONS");
        listController.fetchMore();
      }
    });
  }

  Widget _pokemonCard(BuildContext context, Pokemon pokemon) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PokemonDetails(
                    pokemon: pokemon,
                  ))),
      child: Container(
        padding: EdgeInsets.all(5),
        height: 220,
        width: double.maxFinite,
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: pokemonCardList(pokemon),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (listController.list.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.builder(
          controller: _scrollController,
          itemCount: listController.list.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == (listController.list.length - 1) &&
                listController.isLoading.value) {
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                  ],
                ),
              );
            } else {
              final pokemon = listController.list[index];
              return _pokemonCard(context, pokemon);
            }
          });
    });
  }
}
