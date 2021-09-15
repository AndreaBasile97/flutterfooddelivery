import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fooddelivery/interactive/location.dart';
import 'package:fooddelivery/interactive/picker_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchBox extends StatefulWidget {
  final PickerBloc bloc;
  SearchBox(this.bloc);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  SharedPreferences _prefs;
  String address;
  static const String addressKey = 'address';
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => this._prefs = prefs);
      _loadLastAddress();
      addresscontroller.text = this.address;
    });
  }

  final addresscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: addresscontroller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black,
            hintText: 'Cerca il tuo indirizzo',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(25.7),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(25.7),
            ),
          ),
        ),
        noItemsFoundBuilder: (context) => SizedBox.shrink(),
        suggestionsCallback: (pattern) async {
          return await widget.bloc.search(pattern);
        },
        itemBuilder: (BuildContext context, Location location) {
          return Container(
            child: ListTile(
              leading: Icon(
                Icons.location_on,
                color: Colors.redAccent,
              ),
              title: Container(
                margin: EdgeInsets.only(bottom: 7),
                child: Text(
                  location.name,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
              subtitle: Text(location.formattedAddress),
            ),
          );
        },
        onSuggestionSelected: (Location location) async {
          addresscontroller.text = location.formattedAddress;
          await _setAddressPref(location.formattedAddress);
        },
      ),
    );
  }

  void _loadLastAddress() {
    setState(() {
      this.address = this._prefs?.getString(addressKey) ?? null;
    });
  }

  Future<void> _setAddressPref(String address) async {
    await this._prefs?.setString(addressKey, address);
    _loadLastAddress();
  }
}
