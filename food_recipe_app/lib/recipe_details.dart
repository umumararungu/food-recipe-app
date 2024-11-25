import 'package:flutter/material.dart';
import 'api.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String mealId;

  const RecipeDetailScreen({super.key, required this.mealId});

  @override
  // ignore: library_private_types_in_public_api
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late Future<Map<String, dynamic>> recipe;

  @override
  void initState() {
    super.initState();
    recipe = ApiService().fetchRecipeById(widget.mealId); // Fetch recipe by ID
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: recipe,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final meal = snapshot.data!;
            return SingleChildScrollView( // Wrap with SingleChildScrollView
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Meal Thumbnail
                  if (meal['strMealThumb'] != null)
                    Image.network(
                      meal['strMealThumb'],
                      fit: BoxFit.cover,
                    ),
                  SizedBox(height: 8),
                  // Meal Name
                  Text(
                    meal['strMeal'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Instructions
                  Text(
                    'Instructions:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(meal['strInstructions'] ?? 'No instructions available.'),
                  SizedBox(height: 20),
                  // Ingredients
                  Text(
                    'Ingredients:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildIngredients(meal),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // Helper method to build a list of ingredients
  Widget _buildIngredients(Map<String, dynamic> meal) {
    List<Widget> ingredientsList = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = meal['strIngredient$i'] ?? '';
      final measure = meal['strMeasure$i'] ?? '';

      // If both ingredient and measure exist, add to the list
      if (ingredient.isNotEmpty) {
        ingredientsList.add(Text('$ingredient: $measure'));
      }
    }

    return Column(children: ingredientsList);
  }
}