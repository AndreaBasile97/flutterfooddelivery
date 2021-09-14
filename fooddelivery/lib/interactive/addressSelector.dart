import 'package:flutter/material.dart';
import 'package:fooddelivery/interactive/picker_page.dart';

class AddressSelector extends StatefulWidget {
  @override
  _AddressSelectorState createState() => _AddressSelectorState();
}

class _AddressSelectorState extends State<AddressSelector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MapPickerPage());
  }
}
