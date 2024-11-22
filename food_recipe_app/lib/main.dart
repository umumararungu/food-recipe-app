import 'package:flutter/material.dart';
import 'home.dart';
import 'search.dart';
import 'favorite.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Recipe App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/search': (context) => SearchScreen(),
        '/favorite': (context) => FavoritesScreen(),
      },
    );
  }
}
