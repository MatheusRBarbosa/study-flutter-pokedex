import 'package:flutter/material.dart';
import 'package:pokedex/components/PokemonList/PokemonCardList.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/screens/PokemonDetails.dart';
import 'package:pokedex/services/api.dart';

class PokemonList extends StatefulWidget {
  Future<List<Pokemon>> future;
  final ScrollController scrollController;

  PokemonList({Key key, @required this.future, @required this.scrollController})
      : super(key: key);

  @override
  _PokemonList createState() => _PokemonList();
}

class _PokemonList extends State<PokemonList> {
  List<Pokemon> _pokemonList = List<Pokemon>();
  int _offset = 40;
  int _limit = 15;
  bool _isLoading = false;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _setupInitialList();
    _setupScrollListener();
  }

  void _setupInitialList() {
    this.widget.future.then((list) {
      setState(() {
        _pokemonList.addAll(list);
      });
    });
  }

  void _setupScrollListener() {
    this.widget.scrollController.addListener(() {
      double trigger =
          0.8 * this.widget.scrollController.position.maxScrollExtent;

      if (this.widget.scrollController.offset >= trigger && !_isLoading) {
        debugPrint("CARREGANDO MAIS POKEMONS");
        setState(() {
          _isLoading = true;
        });
        _fetchMore();
      }
    });
  }

  void _fetchMore() {
    Future<List<Pokemon>> newList = fetch(_pokemonList, _offset, _limit);
    newList.then((value) {
      setState(() {
        _pokemonList = value;
        _isLoading = false;
        _offset += _limit;
        debugPrint("NOVOS POKEMONS CARREGADOS");
      });
    });
  }

  Widget _pokemonCard(BuildContext context, Pokemon pokemon) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PokemonDetails(
                    pokemon: pokemon,
                  ))),
      child: Container(
        padding: EdgeInsets.all(5),
        height: 220,
        width: double.maxFinite,
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: pokemonCardList(pokemon),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_pokemonList.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
        controller: this.widget.scrollController,
        itemCount: _pokemonList.length,
        itemBuilder: (BuildContext context, int index) {
          var l = _pokemonList.length;
          debugPrint("TOTAL: $l - INDEX: $index isLoading: $_isLoading");
          if (index == (_pokemonList.length - 1) && _isLoading) {
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else {
            final pokemon = _pokemonList[index];
            return _pokemonCard(context, pokemon);
          }
        });
  }
}
