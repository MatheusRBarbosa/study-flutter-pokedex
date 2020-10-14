import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/Controllers/ListController.dart';
import 'package:pokedex/components/PokemonGrid/PokemonCardGrid.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/screens/PokemonDetails.dart';

class PokemonGrid extends StatefulWidget {
  ListController controller;

  PokemonGrid({Key key, @required this.controller}) : super(key: key);

  @override
  _PokemonGrid createState() => _PokemonGrid();
}

class _PokemonGrid extends State<PokemonGrid> {
  ScrollController _scrollController = new ScrollController();

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _setupScrollListener();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      double trigger = 0.8 * _scrollController.position.maxScrollExtent;

      if (_scrollController.offset >= trigger &&
          !widget.controller.isLoading.value) {
        debugPrint("CARREGANDO MAIS POKEMONS");
        widget.controller.fetchMore();
      }
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
    return Obx(() {
      if (widget.controller.list.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return GridView.builder(
          controller: _scrollController,
          itemCount: widget.controller.list.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (BuildContext context, int index) {
            if (index == (widget.controller.list.length - 1) &&
                widget.controller.isLoading.value) {
              return GridTile(
                child: CircularProgressIndicator(),
              );
            } else {
              final pokemon = widget.controller.list[index];
              return _pokemonCard(context, pokemon);
            }
          });
    });
  }
}
