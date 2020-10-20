import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex/components/PokemonList/PokemonCardList.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/screens/PokemonDetails.dart';
import 'package:pokedex/store/listStore.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonList createState() => _PokemonList();
}

class _PokemonList extends State<PokemonList> {
  ScrollController _scrollController = new ScrollController();
  final _listStore = ListStore();

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _listStore.initLoad();
    _setupScrollListener();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      double trigger = 0.8 * _scrollController.position.maxScrollExtent;

      if (_scrollController.offset >= trigger && !_listStore.isLoading) {
        debugPrint("CARREGANDO MAIS POKEMONS");
        //_fetchMore();
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
    return Observer(
      builder: (_) {
        if (_listStore.list.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            controller: _scrollController,
            itemCount: _listStore.list.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == (_listStore.list.length - 1) &&
                  _listStore.isLoading) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              } else {
                final pokemon = _listStore.list[index];
                return _pokemonCard(context, pokemon);
              }
            });
      },
    );
  }
}
