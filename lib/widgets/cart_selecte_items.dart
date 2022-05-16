// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartSelectedItems extends StatefulWidget {
  final CartItem cartItem;
  final String itemKey;
  const CartSelectedItems({
    Key? key,
    required this.cartItem,
    required this.itemKey,
  }) : super(key: key);

  @override
  State<CartSelectedItems> createState() => _CartSelectedItemsState();
}

class _CartSelectedItemsState extends State<CartSelectedItems> {
  @override
  Widget build(BuildContext context) {
    //golobal vars
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final productId = widget.itemKey;

    //provider
    final cart = Provider.of<Cart>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final products = productProvider.items;

    //widget tree
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        margin: const EdgeInsets.only(bottom: 30),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: Theme.of(context).errorColor,
          boxShadow: [
            const BoxShadow(
              color: Colors.black12,
              spreadRadius: 5,
              blurRadius: 15,
            ),
          ],
        ),
        child: const Icon(
          Icons.delete,
          size: 30,
          color: Color(0xffFFFFFF),
        ),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cart.removeItem(
          productId,
        );
        products
            .firstWhere((element) => element.id == productId)
            .toggleIsInCart();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        width: screenSize.width,
        height: 90,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(0xffFFFFFF),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 5,
              blurRadius: 15,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(widget.cartItem.imgUrl),
              ),
            ),
            SizedBox.fromSize(
              size: const Size(10, 10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.cartItem.title,
                  softWrap: true,
                  style: theme.textTheme.headline4!.copyWith(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${widget.cartItem.price} DA",
                      style: theme.textTheme.headline3,
                    ),
                    //a widget to increment the size
                  ],
                ),
              ],
            ),
            //TODO: add a counter to add quantity to the selected item
          ],
        ),
      ),
    );
  }
}
