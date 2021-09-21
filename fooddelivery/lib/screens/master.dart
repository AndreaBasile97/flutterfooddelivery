import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/interactive/bottomNavigationBar.dart';
import 'package:fooddelivery/interactive/carrello.dart';
import 'package:fooddelivery/interactive/prodotti.dart';
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

  static Future<List<Tile>> getAllList(BuildContext context, int flag,
      [String name, String id, String subname, String subid]) async {
    QuerySnapshot refCategoria;
    if (flag == 0) {
      refCategoria =
          await FirebaseFirestore.instance.collection("prodotti").get();
    } else if (flag == 1) {
      refCategoria = await FirebaseFirestore.instance
          .collection("prodotti")
          .doc(id)
          .collection(name)
          .get();
    } else {
      refCategoria = await FirebaseFirestore.instance
          .collection("prodotti")
          .doc(id)
          .collection(name)
          .doc(subid)
          .collection(subname)
          .get();
    }
    var temp;
    List<Tile> tile = [];
    for (int i = 0; i < refCategoria.docs.length; i++) {
      temp = (refCategoria.docs[i].data());
      if (temp['descrizione'] == null) {
        String nome = temp['nome'];
        String key = refCategoria.docs[i].id;
        List<Tile> prodotti;
        if (flag == 1)
          prodotti = await getAllList(context, 2, name, id, nome, key);
        else
          prodotti = await getAllList(context, 1, nome, key);
        Categoria c = Categoria(nome, key, prodotti);
        tile.add(c);
        print("INSERIMENTO CATREGORIA: " + c.key);
      }
    }
    for (int i = 0; i < refCategoria.docs.length; i++) {
      temp = (refCategoria.docs[i].data());
      if (temp['descrizione'] != null) {
        String nome = temp['nome'];
        String descrizione = temp['descrizione'];
        double prezzo = temp['prezzo'].toDouble();
        String key = refCategoria.docs[i].id;
        Prodotto p = Prodotto(nome, key, descrizione, prezzo);
        tile.add(p);
        print("INSERIMENTO PRODOTTO: " + p.key);
      }
    }
    return tile;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllList(context, 0),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Tile> p = snapshot.data as List<Tile>;
            return SafeArea(
                child: ChangeNotifierProvider<Carrello>(
                    create: (context) => Carrello(), child: Bnb(p)));
          } else {
            return Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: Lottie.asset(
                    'asset/animations/loading.json',
                    animate: true,
                    frameRate: FrameRate(90),
                    width: 300,
                  ),
                ));
          }
        });
  }
}
