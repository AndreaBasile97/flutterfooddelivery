import 'package:flutter/material.dart';
import 'package:fooddelivery/interactive/carrello.dart';
import 'package:fooddelivery/screens/cart.dart';
import 'package:fooddelivery/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Carrello>(
        create: (context) => Carrello(),
        child: Scaffold(
          body: IndexedStack(
            children: <Widget>[
              Home(),
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
                    badgeContent: Text(Carrello.i.toString()),
                    showBadge: Carrello.i < 1 ? false : true,
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
        ));
  }
}
