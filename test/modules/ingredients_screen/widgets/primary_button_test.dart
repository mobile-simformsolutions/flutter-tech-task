import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/modules/ingredients_screen/widgets/primary_button.dart';
import 'package:tech_task/values/app_colors.dart';
import 'package:tech_task/values/strings.dart';

void main() {
  testWidgets('PrimaryButton enabled test', (tester) async {
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: PrimaryButton(
        title: AppStrings.getRecipes,
        enabled: true,
        loading: false,
        onTap: () {},
      ),
    ));

    expect(find.byType(FlatButton), findsOneWidget);
    expect(find.text(AppStrings.getRecipes), findsOneWidget);
    expect(find.byType(SpinKitThreeBounce), findsNothing);
    final button = tester.firstWidget(find.byType(FlatButton)) as FlatButton;
    expect(button.color, AppColors.accentColor);
    expect(button.color.opacity, 1);
  });

  testWidgets('PrimaryButton disabled test', (tester) async {
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: PrimaryButton(
        title: AppStrings.getRecipes,
        enabled: false,
        loading: false,
        onTap: () {},
      ),
    ));

    expect(find.byType(FlatButton), findsOneWidget);
    expect(find.text(AppStrings.getRecipes), findsOneWidget);
    expect(find.byType(SpinKitThreeBounce), findsNothing);
    final button = tester.firstWidget(find.byType(FlatButton)) as FlatButton;
    expect(button.disabledColor, AppColors.accentColor.withOpacity(0.5));
  });

  testWidgets('PrimaryButton loading test', (tester) async {
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: PrimaryButton(
        title: AppStrings.getRecipes,
        enabled: true,
        loading: true,
        onTap: () {},
      ),
    ));

    expect(find.byType(FlatButton), findsOneWidget);
    expect(find.text(AppStrings.getRecipes), findsNothing);
    expect(find.byType(SpinKitThreeBounce), findsOneWidget);
  });
}
