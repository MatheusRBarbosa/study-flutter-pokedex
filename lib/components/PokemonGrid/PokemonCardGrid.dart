import 'package:flutter/material.dart';
import 'package:pokedex/Utils/Color.dart';
import 'package:pokedex/models/Pokemon.dart';

Widget pokemonCardGrid(Pokemon pokemon) {
  return Container(
      child: Stack(
    alignment: Alignment.center,
    children: [
      getColorByType(pokemon.types),
      Image.network(pokemon.sprite, fit: BoxFit.contain)
    ],
  ));
}
