import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex/components/PokemonList/PokemonCardList.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/screens/PokemonDetails.dart';
import 'package:pokedex/store/listStore.dart';

class PokemonList extends StatefulWidget {
  ListStore listStore;

  PokemonList({Key key, @required this.listStore}) : super(key: key);

  @override
  _PokemonList createState() => _PokemonList();
}

class _PokemonList extends State<PokemonList> {
  ScrollController _scrollController = new ScrollController();

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    widget.listStore.initLoad();
    _setupScrollListener();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      double trigger = 0.8 * _scrollController.position.maxScrollExtent;

      if (_scrollController.offset >= trigger && !widget.listStore.isLoading) {
        debugPrint("CARREGANDO MAIS POKEMONS");
        widget.listStore.fetchMore();
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
        if (widget.listStore.list.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            controller: _scrollController,
            itemCount: widget.listStore.list.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == (widget.listStore.list.length - 1) &&
                  widget.listStore.isLoading) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              } else {
                final pokemon = widget.listStore.list[index];
                return _pokemonCard(context, pokemon);
              }
            });
      },
    );
  }
}
