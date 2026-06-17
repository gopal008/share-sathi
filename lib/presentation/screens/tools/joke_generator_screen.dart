import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Joke Generator Screen
class JokeGeneratorScreen extends StatefulWidget {
  const JokeGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<JokeGeneratorScreen> createState() => _JokeGeneratorScreenState();
}

class _JokeGeneratorScreenState extends State<JokeGeneratorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('जोक जेनरेटर 😂'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Joke Generator Screen',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Coming Soon...',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
