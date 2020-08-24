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

Widget getColorByType(List<Type> types, bool noBorders) {
  if (types.length == 1) {
    return _oneColorContainer(types[0], noBorders);
  }
  return _twoColorContainer(types, noBorders);
}

Widget _oneColorContainer(Type type, bool noBorders) {
  var color = colors[type.index.name];
  double borderRadius = noBorders ? 0 : 15;

  return Container(
    decoration: BoxDecoration(
        borderRadius: _getBorderRadius(false, false, borderRadius),
        color: color),
  );
}

Widget _twoColorContainer(List<Type> types, bool noBorders) {
  Color color1 = colors[types[0].index.name];
  Color color2 = colors[types[1].index.name];
  double borderRadius = noBorders ? 0 : 15;

  return Container(
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: color1,
                borderRadius: _getBorderRadius(true, false, borderRadius)),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: color2,
                borderRadius: _getBorderRadius(true, true, borderRadius)),
          ),
        ),
      ],
    ),
  );
}

BorderRadius _getBorderRadius(
    bool isMultiColor, bool isSecondColor, double borderRadius) {
  if (isMultiColor) {
    if (isSecondColor) {
      return BorderRadius.only(
          topRight: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius));
    }
    return BorderRadius.only(
        topLeft: Radius.circular(borderRadius),
        bottomLeft: Radius.circular(borderRadius));
  }
  return BorderRadius.all(Radius.circular(borderRadius));
}
