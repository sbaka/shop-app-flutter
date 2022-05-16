// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../providers/products_provider.dart';
import './product_item.dart';

import 'package:provider/provider.dart';

class ProductsGrid extends StatefulWidget {
  final bool showAll;
  const ProductsGrid(this.showAll);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  @override
  Widget build(BuildContext context) {
    //sets a direct communication btw this widget and the productsProvider
    final productData = Provider.of<ProductsProvider>(context);
    final products =
        widget.showAll ? productData.items : productData.favoriteItems;

    return Container(
      margin: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          //prevents the data from changing
          value: products[index],
          child: const ProductItem(),
        ),
        itemCount: products.length,
      ),
    );
  }
}
