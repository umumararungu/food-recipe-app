import 'package:flutter/material.dart';
import 'package:food_recipe_app/recipe_details.dart';
import 'api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> meals;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    meals = ApiService().fetchMeals(); // Default meals fetch
  }

  void _searchMeals() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      setState(() {
        meals = ApiService().fetchMealsByName(query);
      });
    } else {
      setState(() {
        meals =
            ApiService()
                .fetchMeals(); // Revert to default meals if search is empty
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Recipes'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a meal...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchMeals,
                ),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: meals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final mealList = snapshot.data!;
            return ListView.builder(
              itemCount: mealList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        mealList[index]['strMealThumb'] != null
                            ? Image.network(
                              mealList[index]['strMealThumb'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                            : Icon(Icons.fastfood, size: 50),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Text(
                            mealList[index]['strMeal'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.chevron_right),
                          onPressed: () {
                            // Navigate to Recipe Detail Screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => RecipeDetailScreen(
                                      mealId:
                                          mealList[index]['idMeal'], // Pass the meal ID
                                    ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
