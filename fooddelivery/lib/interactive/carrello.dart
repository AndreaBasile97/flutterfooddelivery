import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/interactive/prodotti.dart';

class Carrello extends ChangeNotifier {
  static List<Prodotto> lista = [];
  int i = 0;
  static double conto = 0;
  static String orario = "";

  void incrementa(Prodotto p) {
    if (!lista.contains(p)) {
      lista.add(p);
      p.setQuantity(true);
    } else
      p.setQuantity(true);
    i++;
    conto += p.price;
    print(conto);
    notifyListeners();
    print(printLista());
  }

  void rimuovi(Prodotto p) {
    if (p.quantity == 1) {
      p.setQuantity(false);
      lista.remove(p);
    } else {
      p.setQuantity(false);
    }
    i--;
    conto -= p.price;
    print(conto);
    notifyListeners();
    print(printLista());
  }

  static String printLista() {
    String result = "";
    lista.forEach((element) {
      result += element.nome + " " + element.quantity.toString() + "\n";
    });
    return result;
  }

  void ordina() {
    FirebaseFirestore.instance
        .collection('ordinazioni')
        .add({'ordine': printLista(), 'conto': conto, 'orario': orario});
  }

  void setOrario(String ora) {
    orario = ora;
  }
}
