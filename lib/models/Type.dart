import 'package:pokedex/models/Index.dart';

class Type {
  final int slot;
  final Index index;

  Type({this.slot, this.index});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(slot: json['slot'], index: Index.fromJson(json['type']));
  }
}
