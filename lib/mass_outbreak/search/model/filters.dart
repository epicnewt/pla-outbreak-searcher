
class Filters {
  bool _shiny = true;
  bool _alpha = true;
  bool _male = true;
  bool _female = true;

  Filters(this._shiny, this._alpha, this._male, this._female);

  bool get female => _female;

  bool get male => _male;

  bool get alpha => _alpha;

  bool get shiny => _shiny;
}