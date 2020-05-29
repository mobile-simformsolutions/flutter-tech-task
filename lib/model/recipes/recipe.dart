/// data class representing a recipe
class Recipe {
  /// name of the recipe
  String title;

  /// ingredients used to make the recipe
  List<String> ingredients;

  /// primary constructor
  Recipe({this.title, this.ingredients});

  /// deserializes json into this class
  Recipe.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    ingredients = json['ingredients'].cast<String>();
  }

  /// serializes this class to json
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['title'] = title;
    json['ingredients'] = ingredients;
    return json;
  }
}
