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
        Entry('Panino con pollo', 'Pollo, Salse e Insalata', '3€'),
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
      return ListTile(
          title: Text(root.title),
          isThreeLine: true,
          subtitle: Text(root.description + '\n' + root.price),
          trailing: Wrap(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle),
                tooltip: 'Rimuovi dal carrello',
                onPressed: () {},
              ),
              Text('0'),
              IconButton(
                icon: const Icon(Icons.add_circle),
                tooltip: 'Aggiungi al carrello',
                onPressed: () {},
              ),
            ],
          ));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      subtitle: Text(root.description + '\n' + root.price),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
