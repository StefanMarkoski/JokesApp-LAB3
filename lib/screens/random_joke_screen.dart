import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/joke.dart';

class RandomJokeScreen extends StatelessWidget {
  final Function(Joke) onAddFavorite;

  const RandomJokeScreen({required this.onAddFavorite, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Joke'),
        centerTitle: true,
      ),
      body: FutureBuilder<Joke>(
        future: ApiService.fetchRandomJoke(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No random joke available'));
          }
          final joke = snapshot.data!;
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(joke.setup),
              subtitle: Text(joke.punchline),
              trailing: IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.red),
                onPressed: () {
                  onAddFavorite(joke); // Add to favorites
                  Navigator.pop(context); // Go back to HomeScreen
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
