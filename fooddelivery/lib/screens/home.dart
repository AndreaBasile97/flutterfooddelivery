import 'package:flutter/material.dart';
import 'package:fooddelivery/interactive/carrello.dart';
import 'package:fooddelivery/interactive/prodotti.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final List<Tile> snapshot;
  Home(this.snapshot, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This is handled by the search bar itself.
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                ProdottoItem(snapshot[index]),
            itemCount: snapshot.length,
          )
        ],
      ),
    );
  }
}

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class ProdottoItem extends StatelessWidget {
  const ProdottoItem(this.prodotto);

  final Tile prodotto;

  Widget _buildTiles(Tile root) {
    if (root is Prodotto)
      return CustomTile(prodotto: root);
    else if (root is Categoria)
      return ExpansionTile(
        key: PageStorageKey<Categoria>(root),
        title: Text(root.nome),
        children: root.prodotti.map(_buildTiles).toList(),
      );
    return null;
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
          child: GestureDetector(
            onTap: () => _mostraImmagine(context),
            child: Hero(
              // TODO: il tag deve essere diverso da ogni immagine
              tag: 'tag',
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJtLpm3-3xKOxqDr5UIDqMctl9MUC5YYzI0w&usqp=CAU')),
            ),
          ),
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
                    widget.prodotto.nome,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(widget.prodotto.description),
                  Text(widget.prodotto.price.toStringAsFixed(2) + " €")
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

  void _mostraImmagine(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => Scaffold(
          body: Center(
              child: Hero(
                  tag: 'tag',
                  child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJtLpm3-3xKOxqDr5UIDqMctl9MUC5YYzI0w&usqp=CAU')))),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
