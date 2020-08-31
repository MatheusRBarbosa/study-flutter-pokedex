import 'package:flutter/material.dart';
import 'package:pokedex/components/PokemonList/PokemonCardList.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/screens/PokemonDetails.dart';

class PokemonList extends StatefulWidget {
  final Future<List<Pokemon>> future;
  final ScrollController scrollController;

  PokemonList({Key key, @required this.future, @required this.scrollController})
      : super(key: key);

  @override
  _PokemonList createState() => _PokemonList();
}

class _PokemonList extends State<PokemonList> {
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
    return FutureBuilder<List<Pokemon>>(
        future: this.widget.future,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView(
              controller: this.widget.scrollController,
              children:
                  snapshot.data.map((e) => _pokemonCard(context, e)).toList(),
            );
          }
          return CircularProgressIndicator();
        });
  }
}
