import 'package:flutter/material.dart';

import './cart_page.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

import 'package:provider/provider.dart';

// Used for the popUp menu
enum SelectedChoice {
  showFavoriteOnly,
  showAll,
}

class ProductOverviewPage extends StatefulWidget {
  const ProductOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductOverviewPage> createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  bool _showAll = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Shop"),
        actions: [
          Consumer<Cart>(
            builder: (context, value, ch) => Badge(
              child: ch!,
              value: value.itemCount.toDouble(),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CartPage.routName);
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Color(0xffFFFFFF),
              ),
            ),
          ),
          PopupMenuButton(
            onSelected: (SelectedChoice selectedChoice) {
              setState(() {
                if (selectedChoice == SelectedChoice.showAll) {
                  _showAll = true;
                } else {
                  _showAll = false;
                }
              });
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                child: Text("Show Favorites only"),
                value: SelectedChoice.showFavoriteOnly,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: SelectedChoice.showAll,
              ),
            ],
          ),
        ],
      ),
      body: ProductsGrid(_showAll),
    );
  }
}
