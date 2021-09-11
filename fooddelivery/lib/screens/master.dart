import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/interactive/bottomNavigationBar.dart';
import 'package:fooddelivery/interactive/carrello.dart';
import 'package:fooddelivery/screens/home.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Master extends StatefulWidget {
  const Master({Key key}) : super(key: key);

  @override
  State<Master> createState() => _Master();
}

class _Master extends State<Master> {
  int _selectedIndex = 0;
  int j = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<List<Prodotto>> getAllProdotti(BuildContext context) async {
    QuerySnapshot refProdotti =
        await FirebaseFirestore.instance.collection("prodotti").get();
    var temp;
    List<Prodotto> prodotti = [];
    for (int i = 0; i < refProdotti.docs.length; i++) {
      temp = (refProdotti.docs[i].data());
      String nome = temp['nome'];
      String descrizione = temp['descrizione'];
      String prezzo = temp['prezzo'];
      String key = refProdotti.docs[i].id;
      Prodotto p = Prodotto(nome, key, descrizione, prezzo);
      prodotti.add(p);
      print(p.key);
    }
    return prodotti;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllProdotti(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Prodotto> p = snapshot.data as List<Prodotto>;
            return SafeArea(
                child: ChangeNotifierProvider<Carrello>(
                    create: (context) => Carrello(), child: Bnb(p)));
          } else {
            return Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: Lottie.asset(
                    'asset/animations/loadingfood.json',
                    animate: true,
                    frameRate: FrameRate(90),
                    width: 300,
                  ),
                ));
          }
        });
  }
}
