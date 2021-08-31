import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({Key key}) : super(key: key);

  static const kIcons = <Icon>[Icon(Icons.event), Icon(Icons.home)];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // Use a Builder here, otherwise `DefaultTabController.of(context)` below
      // returns null.
      child: Builder(
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const TabPageSelector(),
              Expanded(
                child: IconTheme(
                  data: IconThemeData(
                    size: 128.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: const TabBarView(children: kIcons),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
