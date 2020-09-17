import 'package:flutter/material.dart';
import 'package:pokedex/screens/Pokedex.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/providers/PokemonListProvider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => PokemonListProvider(),
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Pokedex(),
      },
    );
  }
}
