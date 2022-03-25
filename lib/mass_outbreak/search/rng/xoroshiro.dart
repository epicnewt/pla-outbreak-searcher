
BigInt _rotl(BigInt seed, int shift) => (seed << shift) | (seed >> (64 - shift));

class XOROSHIRO {
  static final ULONG = BigInt.parse("0xFFFFFFFFFFFFFFFF");
  static final DEFAULT_S1 = BigInt.parse("0x82A2B175229D6A5B");
  BigInt s0 = BigInt.zero;
  BigInt s1 = DEFAULT_S1;
  late BigInt _current;

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
}