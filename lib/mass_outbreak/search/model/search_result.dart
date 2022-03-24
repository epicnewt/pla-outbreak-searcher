
class SearchResult {
  final BigInt _seed;
  final List<int> _path;
  final int _rolls;

  SearchResult(this._seed, this._path, this._rolls);

  List<int> get path => _path;
  BigInt get seed => _seed;
  int get rolls => _rolls;
}