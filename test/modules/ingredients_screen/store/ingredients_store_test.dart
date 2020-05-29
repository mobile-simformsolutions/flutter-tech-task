import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:tech_task/api/repository.dart';
import 'package:tech_task/model/ingredients/ingredient.dart';
import 'package:tech_task/model/recipes/recipe.dart';
import 'package:tech_task/modules/ingredients_screen/store/ingredients_store.dart';
import 'package:tech_task/utils/extensions.dart';
import 'package:tech_task/values/enums.dart';

void main() {
  final server = MockWebServer();

  setUp(() async {
    await server.start();
    final body = json.encode(
        [Ingredient(name: 'test', expiryDate: DateTime(1970, 5, 20)).toJson()]);
    server.defaultResponse = MockResponse()
      ..httpCode = 200
      ..body = body;
    repository = Repository(server.url);
  });

  test('test isIngredientNotExpired method', () {
    final store = IngredientsStore();
    expect(
        store.isIngredientNotExpired(
            Ingredient(name: 'expired', expiryDate: DateTime.now())),
        true);
  });

  test('test fetchIngredients method ', () async {
    final store = IngredientsStore();
    await Future.delayed(Duration(seconds: 2));
    expect(store.state, NetworkState.success);
    assert(store.ingredients.isNotEmpty);
    expect(store.ingredients.length, 1);
    expect(store.ingredients.first.name, 'test');
    expect(store.ingredients.first.expiryDate.dateOnly(),
        DateTime(1970, 5, 20).dateOnly());

    server.enqueue(body: 'test');
    await store.fetchIngredients();
    expect(store.state, NetworkState.failure);

    server.enqueue(httpCode: 500);
    await store.fetchIngredients();
    expect(store.state, NetworkState.failure);
  });

  test('test fetchRecipes method ', () async {
    final store = IngredientsStore();
    await Future.delayed(Duration(seconds: 2));
    final recipe = Recipe(title: 'recipe', ingredients: ['test']);
    server.enqueue(body: json.encode([recipe.toJson()]));
    final recipes = await store.fetchRecipes();
    assert(recipes != null);
    assert(recipes.isNotEmpty);
    expect(recipes.first.title, 'recipe');
    assert(recipes.first.ingredients.isNotEmpty);
    expect(recipes.first.ingredients.first, 'test');

    server.enqueue(body: 'test');
    await store.fetchRecipes();
    expect(store.recipeState, NetworkState.failure);

    server.enqueue(httpCode: 500);
    final result = await store.fetchRecipes();
    assert(result == null);
    expect(store.recipeState, NetworkState.failure);
  });
}
