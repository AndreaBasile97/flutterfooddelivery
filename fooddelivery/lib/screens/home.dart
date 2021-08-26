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
      return CustomTile(name: root.title, descrizione: root.description);
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
  const CustomTile({this.name, this.descrizione, key}) : super(key: key);
  final String name;
  final String descrizione;
  @override
  State<CustomTile> createState() => _CustomTile();
}

class _CustomTile extends State<CustomTile> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        widget.descrizione,
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ))
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      value++;
                    });
                  },
                  icon: Icon(Icons.add_circle)),
              Text(value.toString()),
              IconButton(
                  onPressed: value == 0
                      ? null
                      : () {
                          setState(() {
                            value--;
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
