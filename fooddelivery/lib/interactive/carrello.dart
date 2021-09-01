import 'package:flutter/foundation.dart';
import 'package:fooddelivery/screens/home.dart';

class Carrello extends ChangeNotifier {
  List<Prodotto> lista = [];

  void incrementa(Prodotto p) {
    lista.add(p);
    print(lista);
    notifyListeners();
  }

  //Conta quante volte un prodotto è presente nella lista
  int quantitaProdotto(String nomeProdotto) {
    int count = 0;
    if (lista.length > 0) {
      lista.forEach((prodotto) {
        if (prodotto.title == nomeProdotto) {
          count++;
        }
      });
    }
    print(count);
    return count;
  }
}
