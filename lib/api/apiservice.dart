import 'dart:async';

import 'package:chopper/chopper.dart';

part 'apiservice.chopper.dart';

/// api service interface for chopper
@ChopperApi(baseUrl: '')
abstract class ApiService extends ChopperService {
  /// creates an instance of api service which can be used to call endpoints
  static ApiService create([ChopperClient client]) => _$ApiService(client);

  /// fetches all the ingredients from server
  @Get(path: '/ingredients')
  Future<Response> fetchIngredients();
}
