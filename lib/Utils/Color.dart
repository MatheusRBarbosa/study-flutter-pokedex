import 'package:flutter/material.dart';
import 'package:pokedex/models/Type.dart';

var colors = {
  'normal': Colors.deepOrange[100],
  'fighting': Colors.redAccent[100],
  'flying': Colors.lightBlue[100],
  'poison': Colors.purple[400],
  'ground': Colors.brown,
  'rock': Colors.grey,
  'bug': Colors.green[800],
  'ghost': Colors.deepPurpleAccent[100],
  'steel': Colors.blueGrey,
  'fire': Colors.amber[800],
  'water': Colors.lightBlue,
  'grass': Colors.green[300],
  'electric': Colors.yellowAccent,
  'psychic': Colors.deepPurpleAccent,
  'ice': Colors.cyanAccent[400],
  'dragon': Colors.orangeAccent,
  'dark': Colors.grey[900],
  'fairy': Colors.purpleAccent[100],
  'unknown': Colors.white,
  'shadow': Colors.grey[100]
};

Widget getColorByType(List<Type> types) {
  if (types.length == 1) {
    return _oneColorContainer(types[0]);
  }
  return _twoColorContainer(types);
}

Widget _oneColorContainer(Type type) {
  var color = colors[type.index.name];

  return Container(
    decoration: BoxDecoration(
        borderRadius: _getBorderRadius(false, false), color: color),
  );
}

Widget _twoColorContainer(List<Type> types) {
  Color color1 = colors[types[0].index.name];
  Color color2 = colors[types[1].index.name];

  return Container(
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: color1, borderRadius: _getBorderRadius(true, false)),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: color2, borderRadius: _getBorderRadius(true, true)),
          ),
        ),
      ],
    ),
  );
}

BorderRadius _getBorderRadius(bool isMultiColor, bool isSecondColor) {
  if (isMultiColor) {
    if (isSecondColor) {
      return BorderRadius.only(
          topRight: Radius.circular(15), bottomRight: Radius.circular(15));
    }
    return BorderRadius.only(
        topLeft: Radius.circular(15), bottomLeft: Radius.circular(15));
  }
  return BorderRadius.all(Radius.circular(15));
}
