import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  static String printLista() {
    String result = "lista:\n";
    lista.forEach((element) {
      result += element.title + " " + element.quantity.toString() + "\n";
    });
    return result;
  }

  static void doOrdine() {
    FirebaseFirestore.instance
        .collection('ordinazioni')
        .add({'ordine': printLista()});
  }

  static Widget readOrdine() {
    return Scaffold(
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('ordinazioni').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data.docs.map((ordinazione) {
              return Container(
                child: Center(child: Text(ordinazione['ordine'])),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
