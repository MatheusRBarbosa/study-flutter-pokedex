import 'package:pokedex/models/Index.dart';

class Stat {
  final int baseStat;
  final int effort;
  final Index index;

  Stat({this.baseStat, this.effort, this.index});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
        baseStat: json['base_stat'],
        effort: json['effort'],
        index: Index.fromJson(json['stat']));
  }
}
