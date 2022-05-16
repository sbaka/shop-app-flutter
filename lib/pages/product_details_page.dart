import 'package:flutter/material.dart';

import '../pages/cart_page.dart';
import '../providers/cart.dart';
import '../providers/products_provider.dart';

import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  static const routeName = '/product_details';
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    final mediaQ = MediaQuery.of(context);

    //Providers
    final providedProducts = Provider.of<ProductsProvider>(
      context,
      listen: false,
    );
    final loadedProduct = providedProducts.getById(productId);
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Article Details"),
      ),
      body: SizedBox(
        height: mediaQ.size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 25,
                          spreadRadius: 0.2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: Image.network(
                        loadedProduct.imageUrl,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        loadedProduct.title,
                        style: textTheme.headline2,
                      ),
                      Text(
                        "${loadedProduct.price} DA",
                        style: textTheme.headline2,
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Product Description: ",
                      style: textTheme.headline3,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      loadedProduct.description,
                      style: textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      width: 1,
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        //if the item isn't in the cart add it

                        if (!loadedProduct.isInTheCart) {
                          cart.toggleCart(
                            loadedProduct.id,
                            loadedProduct.title,
                            loadedProduct.imageUrl,
                            loadedProduct.price,
                          );
                        }
                        Navigator.pushNamed(context, CartPage.routName)
                            .whenComplete(() {
                          setState(
                            () {},
                          );
                        }); //refreshes the current page after coming back from the cart page;
                      },
                      child: const Text("Order Now"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color?>(
                            colorTheme.secondary,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all<Size>(
                            const Size(250, 50),
                          ),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            textTheme.headline3!,
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        cart.toggleCart(
                          loadedProduct.id,
                          loadedProduct.title,
                          loadedProduct.imageUrl,
                          loadedProduct.price,
                        );
                        loadedProduct.toggleIsInCart();
                        setState(() {});
                      },
                      icon: loadedProduct.isInTheCart
                          ? Icon(
                              Icons.shopping_cart,
                              color: colorTheme.secondary,
                              size: 32,
                            )
                          : Icon(
                              Icons.shopping_cart_outlined,
                              color: colorTheme.secondary,
                              size: 32,
                            ),
                    )
                  ],
                ),
                height: mediaQ.size.width * 0.2,
                width: mediaQ.size.width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
