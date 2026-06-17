import 'package:flutter/material.dart';
import 'dart:async';
import '../../../data/services/time_zone_service.dart';
import '../../../core/constants/app_colors.dart';

/// डिजि���ल घडी - विभिन्न समय क्षेत्रहरूमा
class DigitalClockScreen extends StatefulWidget {
  const DigitalClockScreen({Key? key}) : super(key: key);

  @override
  State<DigitalClockScreen> createState() => _DigitalClockScreenState();
}

class _DigitalClockScreenState extends State<DigitalClockScreen> {
  late Timer _timer;
  late List<TimeZoneInfo> _timeZones;

  @override
  void initState() {
    super.initState();
    TimeZoneService.initializeTimezones();
    _timeZones = TimeZoneService.getAllTimeZones();
    
    // हरेक सेकन्डमा update गर्ने
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('विश्व घडी 🕰️'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _timeZones.length,
        itemBuilder: (context, index) {
          final tz = _timeZones[index];
          final dateTime = TimeZoneService.getTimeInTimeZone(tz.timezone);
          final formattedTime = TimeZoneService.formatTime(dateTime);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryDeep.withOpacity(0.1),
                      AppColors.accentGreen.withOpacity(0.05),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tz.country,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tz.name,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formattedTime,
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'UTC ${tz.offset}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.accentGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
