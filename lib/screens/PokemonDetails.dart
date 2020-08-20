import 'package:flutter/material.dart';

class PokemonDetails extends StatefulWidget {
  @override
  _PokemonStateDetails createState() => _PokemonStateDetails();
}

class _PokemonStateDetails extends State<PokemonDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon'),
      ),
      body: Center(
        child: Text('Tela dois'),
      ),
    );
  }
}
