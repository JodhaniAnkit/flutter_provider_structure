import 'package:flutter/material.dart';
import 'package:flutter_provider_structure/provider/cart_provider.dart';
import 'package:flutter_provider_structure/screens/cart/cart_screen.dart';
import 'package:flutter_provider_structure/screens/shop/shop_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  Size size = Size.zero;
  int currentIndex = 0;

  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  List<Widget> _buildScreens() {
    return [
      const ShopScreen(),
      const CartScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navigatorKeys[currentIndex],
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => _buildScreens()[currentIndex],
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          bottomNavigationBarTheme:
              Theme.of(context).bottomNavigationBarTheme,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.only(
                  bottom: size.height * 0.005,
                ),
                margin: const EdgeInsets.only(
                  bottom: 2,
                ),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:  currentIndex == 0 ? Colors.black : Colors.black26,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Icon(
                      Iconsax.shop,
                      color: currentIndex == 0 ? Colors.black : Colors.black26,
                      size: 20,
                    ),
                  ),
                ),
              ),
              label: "Shop",
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.only(
                  bottom: size.height * 0.005,
                ),
                margin: const EdgeInsets.only(
                  bottom: 2,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: currentIndex == 1 ? Colors.black : Colors.black26,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Icon(
                          Iconsax.bag,
                          color: currentIndex == 1 ? Colors.black : Colors.black26,
                          size: 20,
                        ),
                      ),
                    ),
                    Positioned(
                      top: -5,
                      right: -3,
                      child: context
                              .watch<CartProvider>()
                              .shoppingCart
                              .isNotEmpty
                          ? CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              radius: 10,
                              child: Text(
                                context
                                    .watch<CartProvider>()
                                    .shoppingCart
                                    .length
                                    .toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
              label: "Cart",
            ),
          ],
          currentIndex: currentIndex,
          onTap: (int tab) {
            setState(() {
              currentIndex = tab;
            });
          },
        ),
      ),
    );
  }
}
