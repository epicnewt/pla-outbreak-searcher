extension UBigIntString on String {
  BigInt parseBigInt({int radix = 16}) {
    return BigInt.parse(this, radix: radix);
  }
}