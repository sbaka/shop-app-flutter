import 'package:flutter/cupertino.dart';

//libraries
import 'products.dart';

class ProductsProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    Product(
        id: 'p1',
        title: 'Survettement',
        description:
            "lacoste orignal chriki\nnbdl b arini tali\npas de tka3rir svp.",
        price: 24000,
        imageUrl:
            "https://images.unsplash.com/photo-1483721310020-03333e577078?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1228&q=80"),
    Product(
        id: 'p2',
        title: 'Clavier Méchanique',
        description: "red dragon mahbol chriki tenkhla3",
        price: 1400,
        imageUrl:
            "https://static.fnac-static.com/multimedia/Images/D9/D9/D3/E9/15324121-1505-1505-1/tsp20200728085729/Clavier-mecanique-Anne-Pro-2-Sans-fil-Bluetooth-Retroeclairage-RVB-Touches-programmables-Blanc.jpg"),
    Product(
        id: 'p3',
        title: 'Renault 4',
        description:
            "machia 3 million;\nAnnée 1962;\nAccepte échange avec iphone 10 pro max",
        price: 120000,
        imageUrl: "https://i.ytimg.com/vi/0jSF9JHRa_A/maxresdefault.jpg")
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product getById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
