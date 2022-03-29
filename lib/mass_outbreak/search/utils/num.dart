extension BigIntHex on BigInt {
  toHex() {
    return toRadixString(16).toUpperCase();
  }
}

extension UIntHex on int {
  toHex() {
    var h = (this >>> 60);
    if (h == 0) {
      return (this & 0xFFFFFFFFFFFFFFF).toRadixString(16);
    }
    return h.toRadixString(16) + (this & 0xFFFFFFFFFFFFFFF).toRadixString(16);
  }
}
