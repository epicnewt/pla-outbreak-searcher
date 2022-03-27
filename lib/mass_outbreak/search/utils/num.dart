extension BigIntHex on BigInt {
  toHex() {
    return toRadixString(16).toUpperCase();
  }
}

extension IntHex on int {
  toHex() {
    return toRadixString(16).toUpperCase();
  }
}
