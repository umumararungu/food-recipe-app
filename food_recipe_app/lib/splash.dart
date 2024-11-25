import 'package:flutter/material.dart';
import 'home.dart'; // Import your home screen file

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
            image: DecorationImage( image: AssetImage('assets/images/2.webp'),fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), // Change opacity to black
              BlendMode.darken, // Use the darken blend mode
            ),),
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
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Description text
              Text(
                'Discover delicious recipes and learn how to cook your favorite meals.',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 255, 255, 255),
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
                child: Text("Let's cook 🥣",
                  style: TextStyle(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 0, 131, 154),
                ),),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}