import 'package:chopper/chopper.dart';

import '../model/ingredients/ingredient.dart';
import 'apiservice.dart';

/// single instance that will be used to make api calls
Repository repository;

/// repository for data
class Repository {
  /// api service handle
  ChopperClient chopper;

  /// primary constructor
  Repository(String baseUrl) {
    chopper = ChopperClient(
        baseUrl: baseUrl,
        services: [ApiService.create()],
        interceptors: [CurlInterceptor(), HttpLoggingInterceptor()],
        converter: JsonConverter());
  }

  /// defines minimum timeout for api requests
  static const Duration minTimeOut = Duration(seconds: 30);

  /// defines maximum timeout for api requests
  static const Duration maxTimeOut = Duration(seconds: 60);

  /// fetch appointments
  Future<Response> fetchIngredients() {
    final myService = chopper.getService<ApiService>();
    return myService.fetchIngredients().timeout(maxTimeOut);
  }

  /// fetches all the recipes that can be made from selected ingredients
  Future<Response> fetchRecipes(List<Ingredient> ingredients) {
    final myService = chopper.getService<ApiService>();
    return myService
        .fetchRecipes(ingredients.map((e) => e.name).toList().join(','))
        .timeout(maxTimeOut);
  }
}
