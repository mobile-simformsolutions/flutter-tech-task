import 'package:mobx/mobx.dart';

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

  Future<void> fetchIngredients() async {
    state = NetworkState.loading;
    try {
      // TODO:
      await Future.delayed(Duration(seconds: 3));
      state = NetworkState.success;
    } on Exception catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      state = NetworkState.failure;
    }
  }
}
