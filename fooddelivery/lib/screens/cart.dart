import 'package:flutter/material.dart';
import 'package:fooddelivery/interactive/carrello.dart';
import 'package:fooddelivery/screens/home.dart';
import 'package:lottie/lottie.dart';

class Cart extends StatelessWidget {
  const Cart({Key key}) : super(key: key);

  //static final widgets = <Widget>[CartScreen(), ShipmentScreen()];

  @override
  Widget build(BuildContext context) {
    TabController tabController;

    return DefaultTabController(
        length: 2,
        // Use a Builder here, otherwise DefaultTabController.of(context) below
        // returns null.
        child: Builder(
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: IconTheme(
                    data: IconThemeData(
                      size: 128.0,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: TabBarView(
                        controller: tabController,
                        children: [CartScreen(), ShipmentScreen()]),
                  ),
                ),
                const TabPageSelector(),
              ],
            ),
          ),
        ));
  }
}

// ignore: must_be_immutable
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
          Center(
            child: Lottie.asset('asset/animations/completed.json',
                animate: true, frameRate: FrameRate(90), width: 300),
          )
        ],
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Carrello.getAllOrdini(context);
            },
            child: Text('ordine'),
          )),
    );
  }
}

class ShipmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
