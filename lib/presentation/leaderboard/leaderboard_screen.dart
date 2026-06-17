import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_colors.dart';

/// Leaderboard Screen
class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Prize Info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: AppColors.primaryDeep,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Monthly Prize Pool',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildPrizeRow('🥇 1st Prize', 'Rs. 6,000'),
                    _buildPrizeRow('🥈 2nd Prize', 'Rs. 3,000'),
                    _buildPrizeRow('🥉 3rd Prize', 'Rs. 2,000'),
                  ],
                ),
              ),
            ),
          ),
          // Leaderboard
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              AppStrings.leaderboardTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return _buildLeaderboardItem(
                context,
                index + 1,
                'User ${index + 1}',
                (index + 1) * 100,
              );
            },
          ),
          // Share Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Share app logic
              },
              icon: const Icon(Icons.share),
              label: const Text(AppStrings.shareApp),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrizeRow(String rank, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            rank,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            amount,
            style: const TextStyle(
              color: AppColors.accentGreen,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem(
    BuildContext context,
    int rank,
    String username,
    int points,
  ) {
    Color rankColor = rank == 1
        ? Colors.amber
        : rank == 2
            ? Colors.grey[300]!
            : rank == 3
                ? Colors.orange[700]!
                : Colors.transparent;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        color: rank <= 3 ? rankColor.withOpacity(0.2) : null,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: rankColor,
            child: Text(
              '#$rank',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(username),
          subtitle: Text('$points Points'),
          trailing: rank <= 3
              ? Icon(
                  rank == 1
                      ? Icons.star
                      : rank == 2
                          ? Icons.star_half
                          : Icons.star_border,
                  color: rankColor,
                )
              : null,
        ),
      ),
    );
  }
}
