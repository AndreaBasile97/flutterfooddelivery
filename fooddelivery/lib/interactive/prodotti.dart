class Prodotto extends Tile {
  Prodotto(nome, key, this.description, this.price) : super(nome, key);

  final String description;
  final double price;
  int quantity = 0;

  void setQuantity(bool flag) {
    flag ? quantity++ : quantity--;
  }
}

class Categoria extends Tile {
  final List<Tile> prodotti;

  Categoria(nome, key, this.prodotti) : super(nome, key);
}

class Tile {
  final String nome;
  final String key;

  Tile(this.nome, this.key);
}
