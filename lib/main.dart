// ignore_for_file: unused_import

//packages
import 'package:flutter/material.dart';
import 'package:my_shop_app/pages/cart_page.dart';

//libraries
import './providers/products_provider.dart';
import './providers/cart.dart';
import './pages/my_home_page.dart';
import './pages/product_overview_page.dart';
import './pages/product_details_page.dart';

//third parties
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //golobal vars
    final mainTheme = ThemeData(
      textTheme: GoogleFonts.ubuntuTextTheme().copyWith(
        caption: const TextStyle(
          fontSize: 20,
          color: Color(0xff1F2633),
        ),
        headline2: TextStyle(
          fontSize: 28,
          color: const Color(0xff1F2633),
          fontFamily: GoogleFonts.ubuntu().fontFamily,
        ),

        headline3: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: const Color(0xff1F2633),
          fontFamily: GoogleFonts.lato().fontFamily,
        ),

        //used in cart page as a light font... something like that
        headline5: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: const Color(0xff7a7a7a),
          fontFamily: GoogleFonts.lato().fontFamily,
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: Color(0xff1F2633),
        secondary: Color(0xffFFAD33),
        secondaryVariant: Color(0xff6C7689),
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: mainTheme,
        home: const ProductOverviewPage(),
        routes: {
          ProductDetailsPage.routeName: (context) => const ProductDetailsPage(),
          CartPage.routName: (context) => const CartPage(),
        },
      ),
    );
  }
}
