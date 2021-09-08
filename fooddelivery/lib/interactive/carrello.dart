import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/screens/home.dart';

class Carrello extends ChangeNotifier {
  static List<Prodotto> lista = [];
  static int i = 0;
  void incrementa(Prodotto p) {
    if (!lista.contains(p)) {
      lista.add(p);
      p.setQuantity(true);
    } else
      p.setQuantity(true);
    i++;
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
    print(printLista());
  }

  static String printLista() {
    String result = "lista:\n";
    lista.forEach((element) {
      result += element.title + " " + element.quantity.toString() + "\n";
    });
    return result;
  }

  static void ordina() {
    FirebaseFirestore.instance
        .collection('ordinazioni')
        .add({'ordine': printLista()});
  }

  static Future getAllOrdini(BuildContext context) async {
    QuerySnapshot refOrdini =
        await FirebaseFirestore.instance.collection("ordinazioni").get();
    var ordini = [];
    for (int i = 0; i < refOrdini.docs.length; i++) {
      ordini.add(refOrdini.docs[i].data().toString());
    }
    print(ordini);
  }
}
