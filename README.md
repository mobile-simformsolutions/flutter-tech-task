# Mobile Technical Task
Apps for Lunch Recipes Suggestion

This application shows available ingredient in user's fridge and allows the user to select
ingredients based on expiry date for any selected day for lunch. After selecting ingredients,
user can press `get recipes` button to get all the recipes that can be made using selected
ingredients. It also includes ingredients needed to make a particular recipe.

## Requirements

- IDE: `Android Studio 3.4+` or `VSCode`
- Flutter SDK (Master): 1.19.0+
- Dart SDK: 2.7+
- Working Internet Connection

## Build project

#### 1. Install dependencies
```shell
flutter packages get
```

#### 2. Run `build_runner` for code generation

```shell
flutter pub run build_runner build --delete-conflicting-outputs
```

#### 3. Run Project
```shell
flutter build apk
```

## Run Tests

```shell
flutter test
```

## Usage

```
1. Install and Open app.
2. By default, current date is selected and ingredients will be loaded.
3. Tap on `Calender` icon to select your preferred date and then click on select button.
4. Ingredients will be loaded for selected date. Select ingredients to make recipe.
5. After selecting ingredients, click on `Get Recipes` button to get all the recipes which can
be made using selected ingredients.
6. A list with recipes will be displayed in another window.
```
