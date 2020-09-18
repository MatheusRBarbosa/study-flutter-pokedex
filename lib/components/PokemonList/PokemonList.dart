import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/components/PokemonList/PokemonCardList.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/screens/PokemonDetails.dart';
import 'package:pokedex/providers/PokemonListProvider.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = false;

  void _setupScrollListener(Function fecthMore) {
    _scrollController.addListener(() => _loadMore(fecthMore));
  }

  void _loadMore(Function fetchMore) async {
    double trigger = 0.8 * _scrollController.position.maxScrollExtent;

    if (_scrollController.offset >= trigger && !_isLoading) {
      _loadingState(true);
      await fetchMore();
      _loadingState(false);
    }
  }

  void _loadingState(bool loading) {
    setState(() {
      _isLoading = loading;
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
    var provider = context.watch<PokemonListProvider>();

    _setupScrollListener(provider.fetchMore);
    if (provider.list.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
        controller: _scrollController,
        itemCount: provider.list.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == (provider.list.length - 1)) {
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else {
            final pokemon = provider.list[index];
            return _pokemonCard(context, pokemon);
          }
        });
  }
}
