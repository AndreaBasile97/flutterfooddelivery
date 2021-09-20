import 'package:flutter/material.dart';
import 'package:fooddelivery/interactive/addressSelector.dart';
import 'package:fooddelivery/interactive/carrello.dart';
import 'package:fooddelivery/screens/home.dart';
import 'package:lottie/lottie.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);
  @override
  State<Cart> createState() => CartState();
}

class CartState extends State<Cart> with TickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    print(tabController);
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
                    child: TabBarView(controller: tabController, children: [
                      CartScreen(tabController),
                      ShipmentScreen(),
                    ]),
                  ),
                ),
                TabPageSelector(
                  controller: tabController,
                  selectedColor: Colors.white,
                ),
              ],
            ),
          ),
        ));
  }
}

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  TabController tc;
  CartScreen(TabController tabController) {
    this.tc = tabController;
  }

  @override
  Widget build(BuildContext context) {
    if (Carrello.lista.length > 0)
      return Scaffold(
        // This is handled by the search bar itself.
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Expanded(
                  flex: 7,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) =>
                        ProdottoItem(Carrello.lista[index]),
                    itemCount: Carrello.lista.length,
                  )),
              Expanded(
                  flex: 1,
                  child: Text("Conto totale: " +
                      Carrello.conto.toStringAsFixed(2) +
                      " €"))
            ]),
          ],
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                tc.animateTo(1);
              },
              child: Text('Procedi con la spedizione'),
            )),
      );
    else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('asset/animations/empty.json',
                animate: true, frameRate: FrameRate(90), width: 300),
            Text('Il tuo carrello è vuoto')
          ],
        ),
      );
    }
  }
}

class ShipmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddressSelector(),
    );
  }
}
