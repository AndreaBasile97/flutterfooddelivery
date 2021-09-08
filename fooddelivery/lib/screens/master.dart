import 'package:flutter/material.dart';
import 'package:fooddelivery/interactive/bottomNavigationBar.dart';
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
        create: (context) => Carrello(), child: Bnb());
  }
}
