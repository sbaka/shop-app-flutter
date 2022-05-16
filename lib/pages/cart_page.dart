// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_shop_app/providers/cart.dart';
import 'package:my_shop_app/widgets/cart_selecte_items.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  static const routName = "/cart_item";
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Widget _nothingInCart() {
    return Container(
      margin: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Spacer(),
          Text(
            "No items in the cart yet...",
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  fontSize: 30,
                  fontFamily: GoogleFonts.lato().fontFamily,
                  color: const Color(0xff353b48).withAlpha(95),
                ),
          ),
          Container(
            margin: const EdgeInsets.all(12),
            child: Image.asset("lib\\assets\\GIFs\\empty.gif"),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //global vars
    final screenSize = MediaQuery.of(context).size;
    final mainTheme = Theme.of(context);

    //providers
    final cart = Provider.of<Cart>(context);
    final Map<String, CartItem> cartElements = cart.items;

    //actual widget
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("My Cart")),
      ),
      //body containes two parts:
      //    > the first one being the listview that contains the cart's content
      //    > the part where the total is shown and the proceed btn
      body: cart.itemCount == 0
          ? _nothingInCart()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  width: screenSize.width,
                  height: 450,
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      return CartSelectedItems(
                        cartItem: cartElements.values.toList()[index],
                        itemKey: cartElements.keys.toList()[index],
                      );
                    },
                    itemCount: cart.itemCount,
                  ),
                ),
                Container(
                  color: const Color(0xffFFFFFF),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Total (${cart.itemCount} items):",
                            style: mainTheme.textTheme.headline5,
                          ),
                          Text(
                            "${cart.totalAmount}DA",
                            style: mainTheme.textTheme.headline3!.copyWith(
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text("Order now"),
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all<Size>(
                              Size(
                                screenSize.width,
                                50,
                              ),
                            ),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                              mainTheme.textTheme.headline3!
                                  .copyWith(fontSize: 22.0),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: mainTheme.colorScheme.secondary,
                                ),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              mainTheme.colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
