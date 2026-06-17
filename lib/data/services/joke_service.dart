import 'package:dio/dio.dart';

/// Random Joke Generator Service
class JokeService {
  static const String _baseUrl = 'https://v2.jokeapi.dev';
  final Dio _dio = Dio();

  /// सबै joke types
  static const List<String> jokeTypes = [
    'single',      // एक-लाइन जोक
    'twopart',     // दुई-भाग जोक
  ];

  /// सबै categories
  static const List<String> categories = [
    'general',     // सामान्य
    'knock-knock', // नक-नक
    'programming', // प्रोग्रामिङ्ग
    'spooky',      // डरलाग्दो
    'dark',        // गहिरो
  ];

  /// Random joke लिनुहोस्
  Future<Joke> getRandomJoke({String category = 'general'}) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/joke/$category',
        queryParameters: {
          'format': 'json',
          'type': 'single,twopart',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Joke.fromJson(response.data);
      } else {
        throw Exception('फेल हुयो जोक लोड गर्न: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('नेटवर्क त्रुटि: ${e.message}');
    } catch (e) {
      throw Exception('अनिश्चित त्रुटि: $e');
    }
  }

  /// विशेष category को joke लिनुहोस्
  Future<Joke> getJokeByCategory(String category) async {
    if (!categories.contains(category)) {
      throw Exception('अमान्य category: $category');
    }
    return getRandomJoke(category: category);
  }
}

/// Joke Model
class Joke {
  final String type;      // 'single' वा 'twopart'
  final String category;  // जोकको category
  final String setup;     // पहिलो भाग (twopart को लागि)
  final String? delivery; // दोस्रो भाग (twopart को लागि)
  final String joke;      // पूरो जोक (single को लागि)
  final bool safe;        // सुरक्षित छ कि छैन

  Joke({
    required this.type,
    required this.category,
    required this.setup,
    this.delivery,
    required this.joke,
    required this.safe,
  });

  /// JSON बाट Joke बनाउनुहोस्
  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      type: json['type'] ?? 'single',
      category: json['category'] ?? 'general',
      setup: json['setup'] ?? '',
      delivery: json['delivery'],
      joke: json['joke'] ?? '',
      safe: json['safe'] ?? true,
    );
  }

  /// सम्पूर्ण जोक text लिनुहोस्
  String getFullJoke() {
    if (type == 'twopart' && delivery != null) {
      return '$setup\n\n$delivery';
    }
    return joke;
  }
}
