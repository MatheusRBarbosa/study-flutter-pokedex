import 'package:flutter/material.dart';
import 'package:pokedex/components/PokemonGrid/PokemonCardGrid.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/screens/PokemonDetails.dart';
import 'package:pokedex/services/api.dart';

class PokemonGrid extends StatefulWidget {
  Future<List<Pokemon>> future;

  PokemonGrid({Key key, @required this.future}) : super(key: key);

  @override
  _PokemonGrid createState() => _PokemonGrid();
}

class _PokemonGrid extends State<PokemonGrid> {
  List<Pokemon> _pokemonList = List<Pokemon>();
  ScrollController _scrollController = new ScrollController();
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
    _scrollController.addListener(() {
      double trigger = 0.5 * _scrollController.position.maxScrollExtent;

      if (_scrollController.offset >= trigger && !_isLoading) {
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
        height: 220,
        width: double.maxFinite,
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: pokemonCardGrid(pokemon),
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

    return GridView.builder(
        controller: _scrollController,
        itemCount: _pokemonList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (BuildContext context, int index) {
          if (index == (_pokemonList.length - 1) && _isLoading) {
            return GridTile(
              child: CircularProgressIndicator(),
            );
          } else {
            final pokemon = _pokemonList[index];
            return _pokemonCard(context, pokemon);
          }
        });
  }
}

/*
Widget futurePokemonGrid(Future<List<Pokemon>> future) {
  return FutureBuilder<List<Pokemon>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return GridView.count(
            crossAxisCount: 4,
            children: List.generate(snapshot.data.length, (index) {
              return _pokemonCard(context, snapshot.data[index]);
            }),
          );
        }
        return CircularProgressIndicator();
      });
}
*/
