import 'package:flutter/material.dart';

import '../pages/product_details_page.dart';
import '../providers/products.dart';
import '../providers/cart.dart';

import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  Widget _coverImage(theme, Product product) {
    return SizedBox(
      height: 110,
      width: 190,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              margin: const EdgeInsets.all(5),
              width: 30,
              height: 30,
              child: CircleAvatar(
                backgroundColor: Colors.white60,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    product.toggleFavorite();
                  },
                  icon: Icon(
                    !product.isFavorite
                        ? Icons.star_border_rounded
                        : Icons.star_rounded,
                    color: theme.colorScheme.secondary,
                    size: 24,
                  ),
                  splashColor: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //utilities
    final theme = Theme.of(context);

    //providers
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        ProductDetailsPage.routeName,
        arguments: product.id,
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(0xffECECEC),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _coverImage(theme, product),
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: Text(
                product.title,
                style: theme.textTheme.headline2!.copyWith(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Text(
                    "${product.price} DZD",
                    style: theme.textTheme.headline3,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    cart.toggleCart(
                      product.id,
                      product.title,
                      product.imageUrl,
                      product.price,
                    );
                    product.toggleIsInCart();
                  },
                  icon: product.isInTheCart
                      ? Icon(
                          Icons.shopping_cart,
                          color: theme.colorScheme.secondary,
                        )
                      : const Icon(
                          Icons.shopping_cart_outlined,
                        ),
                  splashRadius: null,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
