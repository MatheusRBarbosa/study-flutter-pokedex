import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pokedex/models/PokemonIndex.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:http/http.dart' as http;

Future<List<Pokemon>> fetchIndex() async {
  String _url = 'https://pokeapi.co/api/v2/pokemon?limit=40';

  List<Pokemon> pokemons = new List<Pokemon>();
  var response = await http.get(_url);

  if (response.statusCode == 200) {
    PokemonIndex pokemonIndex =
        PokemonIndex.fromJson(json.decode(response.body));

    for (var i = 0; i < pokemonIndex.results.length; i++) {
      String next = pokemonIndex.results[i].url;
      response = await http.get(next);

      if (response.statusCode == 200) {
        Pokemon pokemon = Pokemon.fromJson(json.decode(response.body));
        pokemons.add(pokemon);
      }
    }

    return pokemons;
  } else if (response.statusCode == 404) {
    return null;
  }
}

Future<List<Pokemon>> fetch(
    List<Pokemon> pokemons, int offset, int limit) async {
  String _url = 'https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=$limit';

  var response = await http.get(_url);

  if (response.statusCode == 200) {
    PokemonIndex pokemonIndex =
        PokemonIndex.fromJson(json.decode(response.body));

    for (var i = 0; i < pokemonIndex.results.length; i++) {
      String next = pokemonIndex.results[i].url;
      response = await http.get(next);

      if (response.statusCode == 200) {
        Pokemon pokemon = Pokemon.fromJson(json.decode(response.body));
        pokemons.add(pokemon);
      }
    }
    debugPrint('Fetched offset: $offset');
    return pokemons;
  } else if (response.statusCode == 404) {
    return null;
  }
}
