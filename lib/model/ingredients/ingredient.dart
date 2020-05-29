import 'package:intl/intl.dart';

/// data class representing an ingredient
class Ingredient {
  /// name of the ingredient
  String name;

  /// expiry date for the ingredient
  DateTime expiryDate;

  /// primary constructor
  Ingredient({this.name, this.expiryDate, this.isSelected = false});

  /// represents the selection state of the ingredient
  bool isSelected = false;

  /// creates an instance of this class from json
  Ingredient.fromJson(Map<String, dynamic> json) {
    name = json['title'];
    if (json['use-by'] != null) {
      expiryDate = DateTime.tryParse(json['use-by']);
    }
  }

  /// serializes this class as json
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['title'] = name;
    if (expiryDate != null) {
      json['use-by'] = DateFormat('yyyy-MM-dd').format(expiryDate);
    }
    return json;
  }
}
