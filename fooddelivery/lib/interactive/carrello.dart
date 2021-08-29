import 'package:flutter/foundation.dart';
import 'package:fooddelivery/screens/home.dart';

class Carrello extends ChangeNotifier {
  var lista = [];

  void incrementa(String p) {
    lista.add(p);
    print(lista);
    notifyListeners();
  }
}
