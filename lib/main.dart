import 'package:flutter/material.dart';
import 'package:flutter_provider_structure/common/route_generator.dart';
import 'package:flutter_provider_structure/common/routes.dart';
import 'package:flutter_provider_structure/common/theme.dart';
import 'package:flutter_provider_structure/provider/cart_provider.dart';
import 'package:flutter_provider_structure/provider/favorite_provider.dart';
import 'package:flutter_provider_structure/provider/product_provider.dart';
import 'package:flutter_provider_structure/screens/dashboard/dashboard.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Provider Structure',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      themeMode: ThemeMode.light,
      home: const Base(),
      initialRoute: Routes.base,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
