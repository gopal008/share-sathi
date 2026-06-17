import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Digital Clock Screen - विभिन्न Time Zones
class DigitalClockScreen extends StatefulWidget {
  const DigitalClockScreen({Key? key}) : super(key: key);

  @override
  State<DigitalClockScreen> createState() => _DigitalClockScreenState();
}

class _DigitalClockScreenState extends State<DigitalClockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('विश्व घडी 🌍'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Digital Clock Screen',
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
