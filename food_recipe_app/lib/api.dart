import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://www.themealdb.com/api/json/v1/1/';

  Future<List<dynamic>> fetchMeals() async {
    final response = await http.get(
      Uri.parse('${baseUrl}filter.php?c=fish'), // Fetch seafood meals
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['meals'] ?? [];
    } else {
      throw Exception('Failed to load meals: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> fetchMealsByName(String name) async {
    final response = await http.get(
      Uri.parse('${baseUrl}search.php?s=$name'), // Search meals by name
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['meals'] ?? []; // Return meals or empty list
    } else {
      throw Exception('Failed to load meals: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchRecipeById(String mealId) async {
    final response = await http.get(
      Uri.parse('${baseUrl}lookup.php?i=$mealId'), // Fetch meal details by ID
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['meals'] != null && data['meals'].isNotEmpty 
        ? data['meals'][0] // Return the recipe details of the first meal
        : {};
    } else {
      throw Exception('Failed to load recipe: ${response.statusCode}');
    }
  }
}
