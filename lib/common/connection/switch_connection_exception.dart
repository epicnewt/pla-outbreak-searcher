class SwitchConnectionException implements Exception {
  final List<String> availableAddresses;

  SwitchConnectionException(this.availableAddresses);
}