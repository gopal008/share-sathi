import 'package:flutter/material.dart';
import 'dart:async';
import '../../../core/constants/app_colors.dart';

/// समय क्षेत्र की जानकारी
class TimeZoneInfo {
  final String name;           // नाम
  final String timezone;       // Timezone ID
  final String offset;         // UTC offset
  final String country;        // देश को नाम र flag

  TimeZoneInfo({
    required this.name,
    required this.timezone,
    required this.offset,
    required this.country,
  });
}

/// डिजिटल घडी - विभिन्न समय क्षेत्रहरू
class DigitalClockScreen extends StatefulWidget {
  const DigitalClockScreen({Key? key}) : super(key: key);

  @override
  State<DigitalClockScreen> createState() => _DigitalClockScreenState();
}

class _DigitalClockScreenState extends State<DigitalClockScreen> {
  late Timer _timer;
  late List<TimeZoneInfo> _timeZones;
  final Map<String, DateTime> _times = {};

  // सबै महत्वपूर्ण समय क्षेत्र
  static const List<Map<String, String>> timeZonesData = [
    {'name': 'नेपाल समय (NPT)', 'timezone': 'Asia/Kathmandu', 'offset': '+5:45', 'country': '🇳🇵 नेपाल'},
    {'name': 'भारतीय समय (IST)', 'timezone': 'Asia/Kolkata', 'offset': '+5:30', 'country': '🇮🇳 भारत'},
    {'name': 'बाङ्गलादेश (BDT)', 'timezone': 'Asia/Dhaka', 'offset': '+6:00', 'country': '🇧🇩 बाङ्गलादेश'},
    {'name': 'थाइल्यान्ड (ICT)', 'timezone': 'Asia/Bangkok', 'offset': '+7:00', 'country': '🇹🇭 थाइल्यान्ड'},
    {'name': 'चीन (CST)', 'timezone': 'Asia/Shanghai', 'offset': '+8:00', 'country': '🇨🇳 चीन'},
    {'name': 'जापान (JST)', 'timezone': 'Asia/Tokyo', 'offset': '+9:00', 'country': '🇯🇵 जापान'},
    {'name': 'अस्ट्रेलिया (AEST)', 'timezone': 'Australia/Sydney', 'offset': '+10:00', 'country': '🇦🇺 अस्ट्रेलिया'},
    {'name': 'ब्रिटेन (GMT)', 'timezone': 'Europe/London', 'offset': '+0:00', 'country': '🇬🇧 ब्रिटेन'},
    {'name': 'यूरोप (CET)', 'timezone': 'Europe/Paris', 'offset': '+1:00', 'country': '🇪🇺 य��रोप'},
    {'name': 'न्यूयोर्क (EST)', 'timezone': 'America/New_York', 'offset': '-5:00', 'country': '🇺🇸 अमेरिका'},
    {'name': 'लस एन्जिल्स (PST)', 'timezone': 'America/Los_Angeles', 'offset': '-8:00', 'country': '🇺🇸 USA'},
    {'name': 'टोरन्टो (EST)', 'timezone': 'America/Toronto', 'offset': '-5:00', 'country': '🇨🇦 क्यानाडा'},
    {'name': 'साओ पाउलो (BRT)', 'timezone': 'America/Sao_Paulo', 'offset': '-3:00', 'country': '🇧🇷 ब्राजिल'},
    {'name': 'दुबई (GST)', 'timezone': 'Asia/Dubai', 'offset': '+4:00', 'country': '🇦🇪 दुबई'},
    {'name': 'सिंगापुर (SGT)', 'timezone': 'Asia/Singapore', 'offset': '+8:00', 'country': '🇸🇬 सिंगापुर'},
  ];

  @override
  void initState() {
    super.initState();
    _initializeTimeZones();
    _startTimer();
  }

  void _initializeTimeZones() {
    _timeZones = timeZonesData.map((tz) {
      return TimeZoneInfo(
        name: tz['name']!,
        timezone: tz['timezone']!,
        offset: tz['offset']!,
        country: tz['country']!,
      );
    }).toList();
  }

  void _startTimer() {
    // तुरुन्त update गर्ने
    _updateTimes();
    
    // हरेक सेकेन्डमा update गर्ने
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _updateTimes();
      });
    });
  }

  void _updateTimes() {
    for (var tz in _timeZones) {
      // Simple time calculation - UTC offset अनुसार
      final now = DateTime.now();
      final offset = _parseOffset(tz.offset);
      _times[tz.timezone] = now.add(Duration(
        hours: offset['hours']!,
        minutes: offset['minutes']!,
      ));
    }
  }

  Map<String, int> _parseOffset(String offset) {
    // "+5:45" या "-5:00" format
    final isNegative = offset.startsWith('-');
    final parts = offset.substring(1).split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    
    return {
      'hours': isNegative ? -hours : hours,
      'minutes': isNegative ? -minutes : minutes,
    };
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final second = dateTime.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
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
        title: const Text('विश्व घडी 🌍'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _timeZones.length,
        itemBuilder: (context, index) {
          final tz = _timeZones[index];
          final time = _times[tz.timezone] ?? DateTime.now();
          final formattedTime = _formatTime(time);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryDeep.withOpacity(0.08),
                      AppColors.accentGreen.withOpacity(0.04),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tz.country,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
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
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formattedTime,
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                            fontSize: 22,
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
