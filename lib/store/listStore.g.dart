// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListStore on _ListStore, Store {
  final _$listAtom = Atom(name: '_ListStore.list');

  @override
  List<Pokemon> get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(List<Pokemon> value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_ListStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  @override
  String toString() {
    return '''
list: ${list},
isLoading: ${isLoading}
    ''';
  }
}
