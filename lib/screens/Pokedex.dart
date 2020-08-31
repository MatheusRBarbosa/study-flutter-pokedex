import 'package:flutter/material.dart';
import 'package:pokedex/components/PokemonGrid/PokemonGrid.dart';
import 'package:pokedex/components/PokemonList/PokemonList.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/services/api.dart';

class Pokedex extends StatefulWidget {
  @override
  _PokedexState createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  int _selectedIndex = 0;
  static Future<List<Pokemon>> _futurePokemons = fetchIndex();
  static ScrollController _scrollController = new ScrollController();

  List<Widget> _widgetTabs = <Widget>[
    PokemonList(
      future: _futurePokemons,
      scrollController: _scrollController,
    ),
    futurePokemonGrid(_futurePokemons)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
      ),
      body: Center(
        child: _widgetTabs.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('Modo lista')),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_on), title: Text('Modo grid')),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
