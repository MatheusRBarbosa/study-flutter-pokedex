import 'package:flutter/material.dart';
import 'package:pokedex/components/PokemonList/PokemonCardList.dart';
import 'package:pokedex/models/Pokemon.dart';

Widget futurePokemonList(Future<List<Pokemon>> future) {
  return FutureBuilder<List<Pokemon>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return ListView(
            children: snapshot.data.map((e) => _pokemonCard(e)).toList(),
          );
        }
        return CircularProgressIndicator();
      });
}

Widget _pokemonCard(Pokemon pokemon) {
  return Container(
    padding: EdgeInsets.all(5),
    height: 220,
    width: double.maxFinite,
    child: Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: pokemonCardList(pokemon),
    ),
  );
}
