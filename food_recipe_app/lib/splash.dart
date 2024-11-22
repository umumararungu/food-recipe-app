import 'package:flutter/material.dart';
import 'home.dart'; // Import your home screen file

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Welcome'),
      ),
      body: DecoratedBox( 
          // BoxDecoration takes the image
          decoration: BoxDecoration( 
            // Image set to background of the body
            image: DecorationImage( image: AssetImage('images/bg.jpeg'), fit: BoxFit.cover),
          ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Welcome text
              Text(
                'Welcome to Food Recipes!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Description text
              Text(
                'Discover delicious recipes and learn how to cook your favorite meals. Search for recipes, save your favorites, and more!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              // Button to navigate to HomeScreen
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                child: Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}