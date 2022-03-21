import 'dart:io';

void main() {
  List<Future<String>> f = [];
  for (var i = 100; i > 0; i--) {
      var soc = Socket.connect("192.168.0.$i", 6000, timeout: Duration(seconds: 1)).then((value) {
        print("Connected to 192.168.0.$i");
        return "192.168.0.$i";
      }).onError((error, stackTrace) {
        return "";
      });
      f.add(soc);
  }

  Future.wait(f).then((value) {
    return value.where((element) => element.isNotEmpty);
  });
}
