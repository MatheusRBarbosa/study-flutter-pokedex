import 'package:flutter/material.dart';
import 'package:pokedex/Utils/Color.dart';
import 'package:pokedex/models/Pokemon.dart';

class PokemonDetails extends StatefulWidget {
  final Pokemon pokemon;

  PokemonDetails({Key key, @required this.pokemon}) : super(key: key);

  @override
  _PokemonStateDetails createState() => _PokemonStateDetails();
}

class _PokemonStateDetails extends State<PokemonDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.widget.pokemon.getNameCapitalize()),
        ),
        body: Column(
          children: [_imageStack()],
        ));
  }

  Widget _imageStack() {
    return Container(
      height: 200,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          getColorByType(this.widget.pokemon.types, true),
          Image.network(this.widget.pokemon.sprite,
              width: 200, fit: BoxFit.contain)
        ],
      ),
    );
  }
}
