import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/modules/ingredients_screen/widgets/ingredients_placeholder.dart';
import 'package:tech_task/modules/ingredients_screen/widgets/primary_button.dart';
import 'package:tech_task/values/app_colors.dart';
import 'package:tech_task/values/enums.dart';
import 'package:tech_task/values/strings.dart';

void main() {
  testWidgets('ingredients_placeholder loading test', (tester) async {
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: IngredientsPlaceholder(
        state: NetworkState.loading,
        onRetry: () {},
      ),
    ));

    expect(find.text(AppStrings.ingredientsLoadingSubtitle), findsOneWidget);
    expect(find.text(AppStrings.retry), findsNothing);
    expect(find.byType(SpinKitThreeBounce), findsOneWidget);
  });

  testWidgets('ingredients_placeholder error test', (tester) async {
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: IngredientsPlaceholder(
        state: NetworkState.failure,
        onRetry: () {},
      ),
    ));

    expect(find.text(AppStrings.ingredientsErrorSubtitle), findsOneWidget);
    expect(find.text(AppStrings.retry), findsOneWidget);
    expect(find.byType(FlatButton), findsOneWidget);
    expect(find.byType(PrimaryButton), findsOneWidget);
    final button = tester.firstWidget(find.byType(FlatButton)) as FlatButton;
    expect(button.color, AppColors.accentColor);
    expect(find.byType(SpinKitThreeBounce), findsNothing);
  });

  testWidgets('ingredients_placeholder success test', (tester) async {
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: IngredientsPlaceholder(
        state: NetworkState.success,
        onRetry: () {},
      ),
    ));

    expect(find.text(AppStrings.noIngredientsSubtitle), findsOneWidget);
    expect(find.byType(FlatButton), findsNothing);
    expect(find.text(AppStrings.retry), findsNothing);
    expect(find.byType(SpinKitThreeBounce), findsNothing);
  });
}
