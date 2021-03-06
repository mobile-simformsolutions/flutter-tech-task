import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'api/repository.dart';
import 'modules/ingredients_screen/store/ingredients_store.dart';
import 'modules/ingredients_screen/widgets/ingredients_screen.dart';
import 'values/app_constants.dart';

void main() {
  _setupLogging();
  repository = Repository(AppConstants.baseUrl);
  runApp(MyApp());
}

/// Entry widget of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
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
      ),
    );
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
