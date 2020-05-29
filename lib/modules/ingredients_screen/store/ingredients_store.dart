import 'package:mobx/mobx.dart';

import '../../../api/repository.dart';
import '../../../model/ingredients/ingredient.dart';
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
    } on Exception catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      state = NetworkState.failure;
    }
  }

  bool isIngredientNotExpired(Ingredient ingredient) {
    return ingredient.expiryDate.isAfter(selectedDate.dateOnly());
  }
}
