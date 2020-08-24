import 'package:flutter/material.dart';
import 'package:pokedex/components/PokemonGrid/PokemonCardGrid.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/screens/PokemonDetails.dart';

Widget futurePokemonGrid(Future<List<Pokemon>> future) {
  return FutureBuilder<List<Pokemon>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return GridView.count(
            crossAxisCount: 4,
            children: List.generate(snapshot.data.length, (index) {
              return _pokemonCard(context, snapshot.data[index]);
            }),
          );
        }
        return CircularProgressIndicator();
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
      height: 220,
      width: double.maxFinite,
      child: Card(
        elevation: 2,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: pokemonCardGrid(pokemon),
      ),
    ),
  );
}
