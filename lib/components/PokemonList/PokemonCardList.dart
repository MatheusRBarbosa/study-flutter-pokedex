import 'package:flutter/material.dart';
import 'package:pokedex/Utils/Color.dart';
import 'package:pokedex/models/Pokemon.dart';

Widget pokemonCardList(Pokemon pokemon) {
  List<Widget> _getLabels(Pokemon pokemon) {
    List<Widget> list = List<Widget>();

    list.add(Text(
      pokemon.getNameCapitalize(),
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ));

    list.add(Text(pokemon.getTypesLabel(),
        style: TextStyle(fontWeight: FontWeight.bold)));

    List<String> stats = pokemon.getStatsLabels();
    for (int i = 0; i < stats.length; i++) {
      var text = Text(stats[i]);
      list.add(text);
    }

    return list;
  }

  return Container(
      child: Row(
    children: [
      Expanded(
          child: Stack(
        alignment: Alignment.center,
        children: [
          getColorByType(pokemon.types),
          Image.network(pokemon.sprite, width: 170, fit: BoxFit.contain)
        ],
      )),
      Container(
        width: 15,
      ),
      Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _getLabels(pokemon),
      ))
    ],
  ));
}
