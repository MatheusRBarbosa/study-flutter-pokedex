import 'package:flutter/material.dart';
import 'package:pokedex/Utils/Color.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:spider_chart/spider_chart.dart';

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
          children: [_imageStack(), _statsLabel(), _statsChart()],
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

  Widget _statsLabel() {
    return Container(
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Atributos',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ));
  }

  Widget _statsChart() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: double.infinity,
      height: 300,
      child: SpiderChart(
        data: this.widget.pokemon.getStatsList().toList(),
        maxValue:
            100, // the maximum value that you want to represent (essentially sets the data scale of the chart)
        colors: <Color>[
          Colors.red,
          Colors.green,
          Colors.blue,
          Colors.yellow,
          Colors.indigo,
          Colors.indigo,
        ],
        labels: ["HP", "Attack", "Defense", "SA", "SD", "Speed"],
      ),
    );
  }
}
