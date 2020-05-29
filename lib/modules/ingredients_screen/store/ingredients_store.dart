import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../api/repository.dart';
import '../../../model/ingredients/ingredient.dart';
import '../../../model/recipes/recipe.dart';
import '../../../utils/extensions.dart';
import '../../../values/enums.dart';

part 'ingredients_store.g.dart';

/// store that manages the state of ingredients screen
class IngredientsStore = _IngredientsStore with _$IngredientsStore;

abstract class _IngredientsStore with Store {
  _IngredientsStore() {
    fetchIngredients();
  }

  @observable
  DateTime selectedDate = DateTime.now();

  @observable
  NetworkState state = NetworkState.loading;

  @observable
  NetworkState recipeState = NetworkState.idle;

  ObservableList<Ingredient> get ingredients => ingredientsObservable.value;

  Observable<ObservableList<Ingredient>> ingredientsObservable =
  Observable(ObservableList.of([]));

  @computed
  bool get isAnySelected => ingredients.any((element) => element.isSelected);

  Future<void> fetchIngredients() async {
    state = NetworkState.loading;
    ingredients.clear();
    try {
      final result = await repository.fetchIngredients();
      if (result.isSuccessful) {
        final list = <Ingredient>[];
        result.body.forEach((json) => list.add(Ingredient.fromJson(json)));
        ingredients.addAll(list);
        state = NetworkState.success;
      } else {
        print(result.error);
        state = NetworkState.failure;
      }
    } on Error catch (error, stacktrace) {
      debugPrint(error.toString());
      debugPrint(stacktrace.toString());
      state = NetworkState.failure;
    }
  }

  Future<List<Recipe>> fetchRecipes() async {
    recipeState = NetworkState.loading;
    try {
      final result = await repository.fetchRecipes(
          ingredients.where((element) => element.isSelected).toList());
      if (result.isSuccessful) {
        final recipes = <Recipe>[];
        result.body.forEach((json) => recipes.add(Recipe.fromJson(json)));
        recipeState = NetworkState.success;
        return recipes;
      } else {
        debugPrint(result.error);
        recipeState = NetworkState.failure;
        return null;
      }
    } on Error catch (error, stacktrace) {
      debugPrint(error.toString());
      debugPrint(stacktrace.toString());
      recipeState = NetworkState.failure;
      return null;
    }
  }

  bool isIngredientNotExpired(Ingredient ingredient) {
    return ingredient.expiryDate.isAfter(selectedDate.dateOnly());
  }
}
