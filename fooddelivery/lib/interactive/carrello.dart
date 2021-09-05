library fooddelivery.globals;

import 'package:flutter/foundation.dart';
import 'package:fooddelivery/screens/home.dart';

class Carrello extends ChangeNotifier {
  static List<Prodotto> lista = [];

  void incrementa(Prodotto p) {
    if (!lista.contains(p)) {
      lista.add(p);
      p.setQuantity(true);
    } else
      p.setQuantity(true);
    print(printLista());
  }

  void rimuovi(Prodotto p) {
    if (p.quantity == 1) {
      p.setQuantity(false);
      lista.remove(p);
    } else
      p.setQuantity(false);
    print(printLista());
  }

  String printLista() {
    String result = "lista:\n";
    lista.forEach((element) {
      result += element.title + " " + element.quantity.toString() + "\n";
    });
    return result;
  }
}
