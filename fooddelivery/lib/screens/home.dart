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
  Prodotto(this.title, this.key, this.description, this.price,
      [this.children = const <Prodotto>[]]);

  final int key;
  final String title;
  final String description;
  final String price;
  int quantity = 0;
  final List<Prodotto> children;

  void setQuantity(bool flag) {
    flag ? quantity++ : quantity--;
  }
}

// Data to display.
List<Prodotto> data = <Prodotto>[
  Prodotto(
    'Panini',
    null,
    '',
    '',
    <Prodotto>[
      Prodotto(
        'Panini di Mare',
        null,
        '',
        '',
        <Prodotto>[
          Prodotto('Panino al salmone', 1, 'Salmone, Maionese, Verdure', '5€'),
          Prodotto('Panino al tonno', 2, 'Salmone, Maionese, Verdure', '2€'),
        ],
      ),
      Prodotto('Panini di terra', null, '', '', <Prodotto>[
        Prodotto('Panino con angus', 3, 'Angus, Salse e Insalata', '4€'),
        Prodotto(
            'Panino con pollo',
            4,
            'Pollo, Salse e Insalata asdasdasdsadasdsadasdasdasdasdasdsadasdsadasdsadasdasdasdsadasdasdasdasdaadsadasd',
            '3€'),
      ]),
    ],
  ),
  Prodotto(
    'Panini',
    null,
    '',
    '',
    <Prodotto>[
      Prodotto(
        'Panini di Mare',
        null,
        '',
        '',
        <Prodotto>[
          Prodotto('Panino al salmone', 5, 'Salmone, Maionese, Verdure', '5€'),
          Prodotto('Panino al tonno', 6, 'Salmone, Maionese, Verdure', '2€'),
        ],
      ),
      Prodotto('Panini di terra', null, '', '', <Prodotto>[
        Prodotto('Panino con angus', 7, 'Angus, Salse e Insalata', '4€'),
        Prodotto('Panino con pollo', 8, 'Pollo, Salse e Insalata', '3€'),
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
    if (root.children.isEmpty) return CustomTile(prodotto: root);
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

class CustomTile extends StatefulWidget {
  CustomTile({this.prodotto, key}) : super(key: key);

  final Prodotto prodotto;

  @override
  State<CustomTile> createState() => _CustomTile();
}

class _CustomTile extends State<CustomTile>
    with AutomaticKeepAliveClientMixin<CustomTile> {
  void _incremento() {
    setState(() {
      Provider.of<Carrello>(context, listen: false).incrementa(widget.prodotto);
    });
  }

  void _rimuovi() {
    setState(() {
      Provider.of<Carrello>(context, listen: false).rimuovi(widget.prodotto);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                    widget.prodotto.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(widget.prodotto.description),
                  Text(widget.prodotto.price)
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
              Text(widget.prodotto.quantity.toString()),
              IconButton(
                  onPressed: widget.prodotto.quantity == 0
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

  @override
  bool get wantKeepAlive => true;
}
