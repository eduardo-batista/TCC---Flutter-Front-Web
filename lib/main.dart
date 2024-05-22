import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Ideas',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const RecipeHomePage(),
    );
  }
}

class RecipeHomePage extends StatelessWidget {
  const RecipeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coolinary - Recipe Ideas'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(),
            RecipeGrid(),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Receitas para você',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Encontre as melhores receitas para o seu almoço ou jantar',
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }
}

class RecipeGrid extends StatelessWidget {
  const RecipeGrid({super.key});

  Future<List<dynamic>> fetchRecipes() async {
    // Mocking the API response
    await Future.delayed(const Duration(seconds: 2)); // Simulating network delay
    return [
      {
        "id": 20,
        "image": "https://www.anamariareceitas.com.br/wp-content/uploads/2022/10/Lasanha-a-bolonhesa.jpg",
        "name": "Arepas"
      },
      {
        "id": 19,
        "image": "https://www.anamariareceitas.com.br/wp-content/uploads/2022/10/Lasanha-a-bolonhesa.jpg",
        "name": "Massaman Curry"
      },
      {
        "id": 22,
        "image": "https://www.anamariareceitas.com.br/wp-content/uploads/2022/10/Lasanha-a-bolonhesa.jpg",
        "name": "Chicken Fajitas"
      },
      {
        "id": 23,
        "image": "https://www.anamariareceitas.com.br/wp-content/uploads/2022/10/Lasanha-a-bolonhesa.jpg",
        "name": "Tiramisù"
      },
      {
        "id": 24,
        "image": "https://www.anamariareceitas.com.br/wp-content/uploads/2022/10/Lasanha-a-bolonhesa.jpg",
        "name": "Pork Belly Buns"
      },
      {
        "id": 25,
        "image": "https://www.anamariareceitas.com.br/wp-content/uploads/2022/10/Lasanha-a-bolonhesa.jpg",
        "name": "Caprese Salad"
      },
      {
        "id": 26,
        "image": "https://www.anamariareceitas.com.br/wp-content/uploads/2022/10/Lasanha-a-bolonhesa.jpg",
        "name": "Chicken Milanese"
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchRecipes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No recipes found'));
        } else {
          final recipes = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 3 / 2,
            ),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return RecipeCard(
                title: recipes[index]['name'],
                imageUrl: recipes[index]['image'],
              );
            },
          );
        }
      },
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const RecipeCard({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}