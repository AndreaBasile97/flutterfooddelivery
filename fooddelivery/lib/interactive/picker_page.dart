import 'package:flutter/material.dart';
import 'package:fooddelivery/interactive/orario.dart';
import 'package:fooddelivery/interactive/picker_bloc.dart';
import 'package:fooddelivery/interactive/search_box.dart';
import 'package:provider/provider.dart';

import 'carrello.dart';

class MapPickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<PickerBloc>(
        create: (context) => PickerBloc.getInstance(),
        child: MapPickerBody(),
      ),
    );
  }
}

class MapPickerBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PickerBloc>(
      builder: (context, bloc, child) => Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [SearchBox(bloc), PickerTime()],
            ),
          ),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<Carrello>(context, listen: false).ordina();
                },
                child: Text('Effettua l\'ordinazione'),
              ))
        ],
      ),
    );
  }
}
