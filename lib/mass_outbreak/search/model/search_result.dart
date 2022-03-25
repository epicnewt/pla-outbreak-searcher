
import 'package:mmo_searcher/pokedex/gender_ratios.dart';

class SearchResult {
  final BigInt _seed;
  final List<int> _path;
  final int _rolls;
  final PokedexEntry _pkmn;

  SearchResult(this._seed, this._path, this._rolls, this._pkmn);

  List<int> get path => _path;
  BigInt get seed => _seed;
  int get rolls => _rolls;
  PokedexEntry get pkmn => _pkmn;
}