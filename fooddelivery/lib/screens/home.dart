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
  const Entry(this.title, this.description, [this.children = const <Entry>[]]);
  final String title;
  final String description;
  final List<Entry> children;
}

// Data to display.
const List<Entry> data = <Entry>[
  Entry(
    'Panini',
    '',
    <Entry>[
      Entry(
        'Panini di Mare',
        '',
        <Entry>[
          Entry('Panino al salmone', 'Salmone, Maionese, Verdure'),
          Entry('Panino al tonno', 'Salmone, Maionese, Verdure'),
        ],
      ),
      Entry('Panino di terra', '', <Entry>[
        Entry('Panino con angus', 'Angus, Salse e Insalata'),
        Entry('Panino con pollo', 'Pollo, Salse e Insalata'),
      ]),
    ],
  ),
  Entry(
    'Pizze',
    '',
    <Entry>[
      Entry(
        'Pizze rosse',
        '',
        <Entry>[
          Entry('Pizza Margherita', 'Mozzarella, Pomodoro, Olio e Basilico'),
          Entry('Pizza Marinara', 'Pomodoro, Olio, Basilico e Aglio'),
        ],
      ),
      Entry(
        'Pizze speciali',
        '',
        <Entry>[
          Entry('Pizza X', 'Mozzarella, Pomodoro, Olio e Basilico'),
          Entry('Pizza Y', 'Pomodoro, Olio, Basilico e Aglio'),
        ],
      ),
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
        subtitle: Text(root.description),
      );
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      subtitle: Text(root.description),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
