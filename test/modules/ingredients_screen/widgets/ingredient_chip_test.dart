import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/modules/ingredients_screen/widgets/ingredient_chip.dart';

void main() {
  testWidgets('IngredientChip widget test', (tester) async {
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: IngredientChip(
        title: 'Milk',
        enabled: true,
        selected: false,
      ),
    ));

    expect(find.text('Milk'), findsOneWidget);
    expect(find.text('Milk'), isInCard);
  });
}
