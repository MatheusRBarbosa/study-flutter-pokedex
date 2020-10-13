import 'package:flutter/material.dart';
import 'package:pokedex/screens/Pokedex.dart';
import 'package:pokedex/screens/PokemonDetails.dart';
import 'package:get/get.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Pokedex(),
        '/pokemon': (context) => PokemonDetails()
      },
    );
  }
}
