import 'package:flutter/material.dart';
import 'package:fooddelivery/interactive/floating_search_bar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This is handled by the search bar itself.
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          buildFloatingSearchBar(),
        ],
      ),
    );
  }
}
