import 'package:flutter/material.dart';
import '../../../data/services/joke_service.dart';
import '../../../core/constants/app_colors.dart';

/// Random Joke Generator
class JokeGeneratorScreen extends StatefulWidget {
  const JokeGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<JokeGeneratorScreen> createState() => _JokeGeneratorScreenState();
}

class _JokeGeneratorScreenState extends State<JokeGeneratorScreen> {
  final JokeService _jokeService = JokeService();
  Joke? _currentJoke;
  bool _isLoading = false;
  String _selectedCategory = 'general';
  final List<String> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadRandomJoke();
  }

  Future<void> _loadRandomJoke() async {
    setState(() => _isLoading = true);
    try {
      final joke = await _jokeService.getJokeByCategory(_selectedCategory);
      setState(() {
        _currentJoke = joke;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('त्रुटि: $e')),
        );
      }
    }
  }

  void _toggleFavorite() {
    if (_currentJoke == null) return;
    setState(() {
      final jokeText = _currentJoke!.getFullJoke();
      if (_favorites.contains(jokeText)) {
        _favorites.remove(jokeText);
      } else {
        _favorites.add(jokeText);
      }
    });
  }

  void _shareJoke() {
    if (_currentJoke == null) return;
    // Share functionality यहाँ आई सक्छ
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('साझा गरिएको!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('जोक जेनरेटर 😂'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Category Selector
            Padding(
              padding: const EdgeInsets.all(16),
              child: DropdownButton<String>(
                value: _selectedCategory,
                isExpanded: true,
                items: JokeService.categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(
                      category == 'general' ? 'सामान्य' :
                      category == 'knock-knock' ? 'नक-नक' :
                      category == 'programming' ? 'प्रोग्रामिङ्ग' :
                      category == 'spooky' ? 'डरलाग्दो' :
                      'गहिरो',
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedCategory = value);
                    _loadRandomJoke();
                  }
                },
              ),
            ),
            // Joke Display
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              )
            else if (_currentJoke != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryDeep.withOpacity(0.05),
                          AppColors.accentGreen.withOpacity(0.05),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentJoke!.getFullJoke(),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 18,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Chip(
                              label: Text(
                                _currentJoke!.safe ? '✓ सुरक्षित' : '⚠️ असुरक्षित',
                              ),
                              backgroundColor: _currentJoke!.safe
                                  ? AppColors.accentGreen.withOpacity(0.2)
                                  : AppColors.accentRed.withOpacity(0.2),
                            ),
                            const SizedBox(width: 8),
                            Chip(
                              label: Text(_currentJoke!.category),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _loadRandomJoke,
                    icon: const Icon(Icons.refresh),
                    label: const Text('नयाँ'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _toggleFavorite,
                    icon: Icon(
                      _currentJoke != null &&
                              _favorites.contains(_currentJoke!.getFullJoke())
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    label: const Text('पसंद'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _shareJoke,
                    icon: const Icon(Icons.share),
                    label: const Text('साझा'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Favorites Section
            if (_favorites.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'मेरो पसंदको जोकहरू (${_favorites.length})',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _favorites.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                              _favorites[index],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _favorites.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
