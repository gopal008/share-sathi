import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_strings.dart';

/// IPO Result Screen
class IPOResultScreen extends StatefulWidget {
  const IPOResultScreen({Key? key}) : super(key: key);

  @override
  State<IPOResultScreen> createState() => _IPOResultScreenState();
}

class _IPOResultScreenState extends State<IPOResultScreen> {
  final TextEditingController _lrnController = TextEditingController();

  @override
  void dispose() {
    _lrnController.dispose();
    super.dispose();
  }

  Future<void> _checkIPOResult() async {
    final String lrn = _lrnController.text.trim();
    if (lrn.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया LRN नम्बर प्रविष्ट गर्नुहोस्')),
      );
      return;
    }

    // CDSC website लाई redirect गर्ने
    final String url = 'https://iporesult.cdsc.com.np';
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Website खोल्न सकिएन')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            // Heading
            Text(
              AppStrings.checkIPOResult,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // LRN Input
            Text(
              AppStrings.enterLRN,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _lrnController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'उदाहरण: 123456789',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.numbers),
              ),
            ),
            const SizedBox(height: 20),
            // Check Button
            ElevatedButton(
              onPressed: _checkIPOResult,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                AppStrings.check,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Info Box
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'जानकारी:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '• यो App को यो फीचर CDSC को official website मा redirect गर्छ।\n• आफ्नो LRN नम्बर राख्नुहोस् र official website मा परिणाम जाँच गर्नुहोस्।\n• यदि server down छ भने बिकल्प हेर्नुहोस्।',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
