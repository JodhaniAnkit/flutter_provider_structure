import 'package:flutter/material.dart';
import 'package:flutter_provider_structure/models/product_model.dart';
import 'package:flutter_provider_structure/provider/cart_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class Product extends StatefulWidget {
  final ProductModel product;

  const Product({
    super.key,
    required this.product,
  });

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: SizedBox(
        width: size.width /2.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: const Color(0xffF2F2F2),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0.5,
                        offset: const Offset(5, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.network(
                      widget.product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: widget.product.isAvailable
                      ? GestureDetector(
                          onTap: () {
                            context
                                .read<CartProvider>()
                                .addToCart(widget.product);
                            ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                 duration: Duration(seconds: 1),
                                backgroundColor:
                                    Colors.grey.withOpacity(0.8),
                                content: const Text(
                                  "Item added!",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.orange,
                            radius: 13,
                            child: Icon(
                              Iconsax.bag,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.020,
            ),
            Text(
              widget.product.name,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: size.width * 0.033,
              ),
            ),
            // there is use max availble size
            SizedBox(
              height: size.height * 0.005,
            ),
            SizedBox(
              child: widget.product.isAvailable
                  ? Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xff03B680),
                          radius: 4,
                        ),
                        SizedBox(
                          width: size.width * 0.020,
                        ),
                        Text(
                          "Available",
                          style: GoogleFonts.poppins(
                            color: const Color(0xff03B680),
                            fontSize: size.width * 0.031,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    )
                  : Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          radius: 4,
                        ),
                        SizedBox(
                          width: size.width * 0.020,
                        ),
                        Text(
                          "Not Available",
                          style: GoogleFonts.poppins(
                            color: Colors.redAccent,
                            fontSize: size.width * 0.031,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
            ),
            SizedBox(
              height: size.height * 0.003,
            ),
            Text(
              "\$ ${widget.product.price}",
              style: GoogleFonts.poppins(
                  color: Colors.grey, fontSize: size.width * 0.040),
            )
          ],
        ),
      ),
    );
  }
}
