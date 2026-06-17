import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_colors.dart';

/// Market Screen
class MarketScreen extends StatefulWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  bool _showGainers = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Toggle Buttons
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() => _showGainers = true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _showGainers
                        ? AppColors.accentGreen
                        : Colors.grey.withOpacity(0.3),
                    foregroundColor: _showGainers ? Colors.white : Colors.grey,
                  ),
                  child: const Text('📈 Gainers'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() => _showGainers = false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !_showGainers
                        ? AppColors.accentRed
                        : Colors.grey.withOpacity(0.3),
                    foregroundColor: !_showGainers ? Colors.white : Colors.grey,
                  ),
                  child: const Text('📉 Losers'),
                ),
              ),
            ],
          ),
        ),
        // Market List
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildMarketItem(
                context,
                'Stock ${index + 1}',
                'Rs. ${1000 + (index * 100)}',
                '+${(index + 1) * 2}%',
                _showGainers,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMarketItem(
    BuildContext context,
    String name,
    String price,
    String change,
    bool isGainer,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: ListTile(
          title: Text(name),
          subtitle: Text(price),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                change,
                style: TextStyle(
                  color: isGainer ? AppColors.accentGreen : AppColors.accentRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                isGainer ? Icons.trending_up : Icons.trending_down,
                color: isGainer ? AppColors.accentGreen : AppColors.accentRed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
