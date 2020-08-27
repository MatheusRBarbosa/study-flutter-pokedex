import 'package:pokedex/models/Stat.dart';
import 'package:pokedex/models/Type.dart';
import 'package:pokedex/Utils/String.dart';

class Pokemon {
  final int id;
  final String name;
  final List<Type> types;
  final List<Stat> stats;
  final String sprite;

  Pokemon({this.id, this.name, this.types, this.stats, this.sprite});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        id: json['id'],
        name: json['name'],
        types: json['types']
            .cast<Map<String, dynamic>>()
            .map<Type>((e) => Type.fromJson(e))
            .toList(),
        stats: json['stats']
            .cast<Map<String, dynamic>>()
            .map<Stat>((e) => Stat.fromJson(e))
            .toList(),
        sprite: json['sprites']['front_default']);
  }

  String getNameCapitalize() {
    return capitalize(this.name);
  }

  List<String> getStatsLabels() {
    List<String> labels = List<String>();

    this.stats.forEach((e) {
      String label = capitalize(e.index.name);
      int value = e.baseStat;
      label += ': $value';
      labels.add(label);
    });

    return labels;
  }

  List<double> getStatsList() {
    List<double> statsList = List<double>();

    this.stats.forEach((e) {
      statsList.add(e.baseStat.toDouble());
    });

    return statsList;
  }

  String getTypesLabel() {
    String label = "";

    for (int i = 0; i < this.types.length; i++) {
      if (i > 0) {
        label += ' | ';
      }
      label += capitalize(this.types[i].index.name);
    }

    return label;
  }
}
