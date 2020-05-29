import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/ingredients_screen/store/ingredients_store.dart';
import 'modules/ingredients_screen/widgets/ingredients_screen.dart';

void main() => runApp(MyApp());

/// Entry widget of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Task Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'GTWalsheim',
      ),
      home: Provider(
        create: (_) => IngredientsStore(),
        child: IngredientsScreen(),
      ),
    );
  }
}
