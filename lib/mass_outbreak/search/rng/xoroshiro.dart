

class XOROSHIRO {
  static final ULONG = BigInt.parse("0xFFFFFFFFFFFFFFFF");
  static final DEFAULT_S1 = BigInt.parse("0x82A2B175229D6A5B");
  BigInt s0 = BigInt.zero;
  BigInt s1 = DEFAULT_S1;
  late BigInt _current;

  BigInt _rotl(BigInt seed, int shift) => (seed << shift) | (seed >> (64 - shift));
  
  reseed(BigInt s0, {BigInt? s1}) {
    this.s0 = s0;
    this.s1 = s1 ?? DEFAULT_S1;
    _current = _updateCurrent();
  }

  BigInt reseedWithNext() {
    var seed = next();
    reseed(seed);
    return seed;
  }

  BigInt state() => (s0 + s1) & ULONG;
  BigInt _updateCurrent() => _current = (s0 + s1) & ULONG;

  BigInt get current => _current;

  BigInt next() {
    _updateCurrent();
    s1 = s0 ^ s1;
    s0 = (_rotl(s0, 24) ^ s1 ^ (s1 << 16)) & ULONG;
    s1 = _rotl(s1, 37) & ULONG;
    return current;
  }

  BigInt _getMask(BigInt x) {
    var mask = x - BigInt.one;
    for( var i = 0 ; i < 6; i++ ) {
      mask |= mask >> (1 << i);
    }
    return mask;
  }

  BigInt rand(BigInt n) {
    var mask = _getMask(n);
    BigInt res = BigInt.zero;
    do {
      res = next() & mask;
    } while(res >= n);
    return res;
  }

  BigInt advanceAndReseed(int times) {
    for (var i = 0; i < times * 2; i++) {
      next();
    }
    reseed(next());
    return s0;
  }
}

class XOROSHIROLite {
  static final ULONG = 0xFFFFFFFFFFFFFFFF;
  static final DEFAULT_S1 = 0x82A2B175229D6A5B;
  int s0 = 0;
  int s1 = DEFAULT_S1;
  late int _current;

  int _rotl(int seed, int shift) => (seed << shift) | (seed >>> (64 - shift));
  
  reseed(int s0, {int? s1}) {
    this.s0 = s0;
    this.s1 = s1 ?? DEFAULT_S1;
    _current = this.s0;
  }

  int reseedWithNext() {
    var seed = next();
    reseed(seed);
    return seed;
  }

  int state() => (s0 + s1) & ULONG;
  int _updateCurrent() => _current = (s0 + s1) & ULONG;

  int get current => _current;

  int next() {
    _updateCurrent();
    s1 = s0 ^ s1;
    s0 = (_rotl(s0, 24) ^ s1 ^ (s1 << 16)) & ULONG;
    s1 = _rotl(s1, 37) & ULONG;
    return current;
  }

  int _getMask(int x) {
    var mask = x - 1;
    for( var i = 0 ; i < 6; i++ ) {
      mask |= mask >>> (1 << i);
    }
    return mask;
  }

  int rand(int n) {
    var mask = _getMask(n);
    int res = 0;
    do {
      res = next() & mask;
    } while(((res >>> 1) > (n >>> 1)) || ((res >>> 1) == (n >>> 1) && ((res & 1) >= (n & 1)))); 
    return res;
  }

  int advanceAndReseed(int times) {
    for (var i = 0; i < times * 2; i++) {
      next();
    }
    reseed(next());
    return s0;
  }
}