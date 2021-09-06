import 'package:flutter/material.dart';
import 'package:fooddelivery/interactive/carrello.dart';
import 'package:fooddelivery/screens/home.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({Key key}) : super(key: key);

  static final widgets = <Widget>[CartScreen(), ShipmentScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [CartScreen()],
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // This is handled by the search bar itself.
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  ProdottoItem(Carrello.lista[index]),
              itemCount: Carrello.lista.length,
            ),
          ],
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Carrello.doOrdine();
              },
              child: Text('Fixed Button'),
            )));
  }
}

class ShipmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
