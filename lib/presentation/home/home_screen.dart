import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_colors.dart';
import '../ipo_result/ipo_result_screen.dart';
import '../news/news_screen.dart';
import '../market/market_screen.dart';
import '../leaderboard/leaderboard_screen.dart';
import '../tools/digital_clock_screen.dart';
import '../tools/joke_generator_screen.dart';

/// Home Screen - Main entry point
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePageContent(),
    const IPOResultScreen(),
    const NewsScreen(),
    const MarketScreen(),
    const LeaderboardScreen(),
  ];

  final List<String> _titles = [
    AppStrings.home,
    AppStrings.ipoResult,
    AppStrings.news,
    AppStrings.market,
    AppStrings.leaderboard,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Notification logic यहाँ आइल
            },
          ),
          IconButton(
            icon: const Icon(Icons.apps),
            onPressed: () {
              _showToolsMenu();
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: AppStrings.ipoResult,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: AppStrings.news,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: AppStrings.market,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: AppStrings.leaderboard,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  /// Tools Menu देखाउने
  void _showToolsMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'उपकरण 🛠️',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('विश्व घडी 🌍'),
              subtitle: const Text('विभिन्न समय क्षेत्र'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DigitalClockScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.sentiment_very_satisfied),
              title: const Text('जोक जेनरेटर 😂'),
              subtitle: const Text('हरेक दिन नयाँ जोक'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const JokeGeneratorScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Home Page Content
class HomePageContent extends StatelessWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Active IPO Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppStrings.activeIPO,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: _buildIPOCard(
                    context,
                    'IPO ${index + 1}',
                    AppStrings.mutualFund,
                    '1 साता बाँकी',
                    AppStrings.riskLow,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // Upcoming IPO Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppStrings.upcomingIPO,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          _buildIPOListItem(context, 'Upcoming IPO 1', '5 दिनमा'),
          _buildIPOListItem(context, 'Upcoming IPO 2', '12 दिनमा'),
          const SizedBox(height: 20),
          // Recently Closed Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppStrings.recentlyClosedIPO,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          _buildIPOListItem(context, 'Closed IPO 1', '2 हप्ता अघि'),
          _buildIPOListItem(context, 'Closed IPO 2', '3 हप्ता अघि'),
        ],
      ),
    );
  }

  Widget _buildIPOCard(
    BuildContext context,
    String name,
    String type,
    String timeLeft,
    String riskLevel,
  ) {
    return Card(
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              type,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Text(
              timeLeft,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Chip(
              label: Text(riskLevel),
              backgroundColor: riskLevel == AppStrings.riskLow
                  ? Colors.green.withOpacity(0.3)
                  : Colors.red.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIPOListItem(
    BuildContext context,
    String name,
    String info,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: ListTile(
          title: Text(name),
          subtitle: Text(info),
          trailing: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
