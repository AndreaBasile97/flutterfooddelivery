import 'package:flutter/material.dart';
import 'package:fooddelivery/interactive/carrello.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Carrello>(
        create: (context) => Carrello(),
        child: Scaffold(
          // This is handled by the search bar itself.
          resizeToAvoidBottomInset: false,
          body: Stack(
            fit: StackFit.expand,
            children: [
              ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    ProdottoItem(data[index]),
                itemCount: data.length,
              )
            ],
          ),
        ));
  }
}

class Prodotto {
  const Prodotto(this.title, this.description, this.price,
      [this.children = const <Prodotto>[]]);
  final String title;
  final String description;
  final String price;
  final List<Prodotto> children;
}

// Data to display.
const List<Prodotto> data = <Prodotto>[
  Prodotto(
    'Panini',
    '',
    '',
    <Prodotto>[
      Prodotto(
        'Panini di Mare',
        '',
        '',
        <Prodotto>[
          Prodotto('Panino al salmone', 'Salmone, Maionese, Verdure', '5€'),
          Prodotto('Panino al tonno', 'Salmone, Maionese, Verdure', '2€'),
        ],
      ),
      Prodotto('Panini di terra', '', '', <Prodotto>[
        Prodotto('Panino con angus', 'Angus, Salse e Insalata', '4€'),
        Prodotto(
            'Panino con pollo',
            'Pollo, Salse e Insalata asdasdasdsadasdsadasdasdasdasdasdsadasdsadasdsadasdasdasdsadasdasdasdasdaadsadasd',
            '3€'),
      ]),
    ],
  ),
  Prodotto(
    'Panini',
    '',
    '',
    <Prodotto>[
      Prodotto(
        'Panini di Mare',
        '',
        '',
        <Prodotto>[
          Prodotto('Panino al salmone', 'Salmone, Maionese, Verdure', '5€'),
          Prodotto('Panino al tonno', 'Salmone, Maionese, Verdure', '2€'),
        ],
      ),
      Prodotto('Panini di terra', '', '', <Prodotto>[
        Prodotto('Panino con angus', 'Angus, Salse e Insalata', '4€'),
        Prodotto('Panino con pollo', 'Pollo, Salse e Insalata', '3€'),
      ]),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class ProdottoItem extends StatelessWidget {
  const ProdottoItem(this.prodotto);

  final Prodotto prodotto;

  Widget _buildTiles(Prodotto root) {
    if (root.children.isEmpty)
      return CustomTile(
          name: root.title, descrizione: root.description, prezzo: root.price);
    return ExpansionTile(
      key: PageStorageKey<Prodotto>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(prodotto);
  }
}

// ignore: must_be_immutable
class CustomTile extends StatefulWidget {
  int value = 0;
  CustomTile({this.name, this.descrizione, this.prezzo, key}) : super(key: key);
  final String name;
  final String descrizione;
  final String prezzo;
  @override
  State<CustomTile> createState() => _CustomTile();
}

class _CustomTile extends State<CustomTile> {
  void _incremento() {
    setState(() {
      widget.value++;
    });
    Provider.of<Carrello>(context, listen: false).incrementa(widget.name);
  }

  void _rimuovi() {
    setState(() {
      widget.value--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJtLpm3-3xKOxqDr5UIDqMctl9MUC5YYzI0w&usqp=CAU')),
        ),
        Expanded(
          flex: 11,
          child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(widget.descrizione),
                  Text(widget.prezzo)
                ],
              )),
        ),
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    _incremento();
                  },
                  icon: Icon(Icons.add_circle)),
              Text(widget.value.toString()),
              IconButton(
                  onPressed: widget.value == 0
                      ? null
                      : () {
                          _rimuovi();
                        },
                  icon: Icon(Icons.remove_circle))
            ],
          ),
        )
      ],
    );
  }
}
