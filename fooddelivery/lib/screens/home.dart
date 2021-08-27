import 'package:flutter/material.dart';

class Home extends StatelessWidget {
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
                EntryItem(data[index]),
            itemCount: data.length,
          )
        ],
      ),
    );
  }
}

class Entry {
  const Entry(this.title, this.description, this.price,
      [this.children = const <Entry>[]]);
  final String title;
  final String description;
  final String price;
  final List<Entry> children;
}

// Data to display.
const List<Entry> data = <Entry>[
  Entry(
    'Panini',
    '',
    '',
    <Entry>[
      Entry(
        'Panini di Mare',
        '',
        '',
        <Entry>[
          Entry('Panino al salmone', 'Salmone, Maionese, Verdure', '5€'),
          Entry('Panino al tonno', 'Salmone, Maionese, Verdure', '2€'),
        ],
      ),
      Entry('Panini di terra', '', '', <Entry>[
        Entry('Panino con angus', 'Angus, Salse e Insalata', '4€'),
        Entry(
            'Panino con pollo',
            'Pollo, Salse e Insalata asdasdasdsadasdsadasdasdasdasdasdsadasdsadasdsadasdasdasdsadasdasdasdasdaadsadasd',
            '3€'),
      ]),
    ],
  ),
  Entry(
    'Panini',
    '',
    '',
    <Entry>[
      Entry(
        'Panini di Mare',
        '',
        '',
        <Entry>[
          Entry('Panino al salmone', 'Salmone, Maionese, Verdure', '5€'),
          Entry('Panino al tonno', 'Salmone, Maionese, Verdure', '2€'),
        ],
      ),
      Entry('Panini di terra', '', '', <Entry>[
        Entry('Panino con angus', 'Angus, Salse e Insalata', '4€'),
        Entry('Panino con pollo', 'Pollo, Salse e Insalata', '3€'),
      ]),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty)
      return CustomTile(
          name: root.title, descrizione: root.description, prezzo: root.price);
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

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
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: CircleAvatar(),
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
                    setState(() {
                      _incremento();
                    });
                  },
                  icon: Icon(Icons.add_circle)),
              Text(widget.value.toString()),
              IconButton(
                  onPressed: widget.value == 0
                      ? null
                      : () {
                          setState(() {
                            widget.value--;
                          });
                        },
                  icon: Icon(Icons.remove_circle))
            ],
          ),
        )
      ],
    );
  }
}
