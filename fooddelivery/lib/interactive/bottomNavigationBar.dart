import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/interactive/carrello.dart';
import 'package:fooddelivery/screens/cart.dart';
import 'package:fooddelivery/screens/home.dart';
import 'package:provider/provider.dart';

class Bnb extends StatefulWidget {
  final List<Prodotto> snapshot;
  const Bnb(this.snapshot, {Key key}) : super(key: key);

  @override
  State<Bnb> createState() => _Bnb();
}

class _Bnb extends State<Bnb> {
  int _selectedIndex = 0;
  int j = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final carrello = context.watch<Carrello>();
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
          Home(widget.snapshot),
          Cart(),
          Text(
            'Profilo',
            style: optionStyle,
          ),
        ],
        index: _selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              label: 'Carrello',
              icon: Badge(
                animationDuration: Duration(milliseconds: 200),
                animationType: BadgeAnimationType.scale,
                badgeContent: Text(
                  carrello.i.toString(),
                  style: TextStyle(fontSize: 10),
                ),
                showBadge: carrello.i < 1 ? false : true,
                child: Icon(Icons.shopping_cart),
              )),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profilo',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
