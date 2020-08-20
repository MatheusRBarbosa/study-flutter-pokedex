import 'package:pokedex/models/Index.dart';

class PokemonIndex {
  final int count;
  final String next;
  final String previous;
  final List<Index> results;

  PokemonIndex({this.count, this.next, this.previous, this.results});

  factory PokemonIndex.fromJson(Map<String, dynamic> json) {
    return PokemonIndex(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: json['results']
            .cast<Map<String, dynamic>>()
            .map<Index>((e) => Index.fromJson(e))
            .toList());
  }
}
