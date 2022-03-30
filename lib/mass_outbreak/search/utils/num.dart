extension BigIntHex on BigInt {
  String  toHex() {
    return toRadixString(16).toUpperCase();
  }
  int toUInt() {
    return ((this >> 1).toInt() << 1) | (this & BigInt.one).toInt();
  }
}

extension UIntString on String {
  int parseUInt({int radix = 16}) {
    return int.parse(substring(1), radix: radix) | (int.parse(substring(0, 1), radix: radix) << (4 * (length - 1)));
  }
}

extension UIntHex on int {
  String toHex() {
    var h = (this >>> 60);
    if (h == 0) {
      return (this & 0xFFFFFFFFFFFFFFF).toRadixString(16).toUpperCase();
    }
    return (h.toRadixString(16) + (this & 0xFFFFFFFFFFFFFFF).toRadixString(16).padLeft(15, "0")).toUpperCase();
  }
}
