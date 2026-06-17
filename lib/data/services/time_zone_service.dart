import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

/// विभिन्न Time Zones को लागि सेवा
class TimeZoneService {
  static void initializeTimezones() {
    tz_data.initializeTimeZones();
  }

  /// सबै महत्वपूर्ण time zones को list
  static List<TimeZoneInfo> getAllTimeZones() {
    return [
      TimeZoneInfo(
        name: 'नेपाल समय (NPT)',
        timezone: 'Asia/Kathmandu',
        offset: '+5:45',
        country: '🇳🇵 नेपाल',
      ),
      TimeZoneInfo(
        name: 'भारतीय समय (IST)',
        timezone: 'Asia/Kolkata',
        offset: '+5:30',
        country: '🇮🇳 भारत',
      ),
      TimeZoneInfo(
        name: 'बाङ्गलादेश (BDT)',
        timezone: 'Asia/Dhaka',
        offset: '+6:00',
        country: '🇧🇩 बाङ्गलादेश',
      ),
      TimeZoneInfo(
        name: 'थाइल्यान्ड (ICT)',
        timezone: 'Asia/Bangkok',
        offset: '+7:00',
        country: '🇹🇭 थाइल्यान्ड',
      ),
      TimeZoneInfo(
        name: 'चीन (CST)',
        timezone: 'Asia/Shanghai',
        offset: '+8:00',
        country: '🇨🇳 चीन',
      ),
      TimeZoneInfo(
        name: 'जापान (JST)',
        timezone: 'Asia/Tokyo',
        offset: '+9:00',
        country: '🇯🇵 जापान',
      ),
      TimeZoneInfo(
        name: 'अस्ट्रेलिया (AEST)',
        timezone: 'Australia/Sydney',
        offset: '+10:00',
        country: '🇦🇺 अस्ट्रेलिया',
      ),
      TimeZoneInfo(
        name: 'ब्रिटेन (GMT)',
        timezone: 'Europe/London',
        offset: '+0:00',
        country: '🇬🇧 ब्रिटेन',
      ),
      TimeZoneInfo(
        name: 'युरोप (CET)',
        timezone: 'Europe/Paris',
        offset: '+1:00',
        country: '🇪🇺 युरोप',
      ),
      TimeZoneInfo(
        name: 'न्यूयोर्क (EST)',
        timezone: 'America/New_York',
        offset: '-5:00',
        country: '🇺🇸 अमेरिका',
      ),
    ];
  }

  /// दिइएको timezone मा current time लिनुहोस्
  static DateTime getTimeInTimeZone(String timezoneId) {
    try {
      tz.initializeTimeZones();
      final location = tz.getLocation(timezoneId);
      return tz.TZDateTime.now(location);
    } catch (e) {
      return DateTime.now();
    }
  }

  /// Time लाई formatted string मा convert गर्नुहोस्
  static String formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final second = dateTime.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }
}

/// Time Zone को Model
class TimeZoneInfo {
  final String name;
  final String timezone;
  final String offset;
  final String country;

  TimeZoneInfo({
    required this.name,
    required this.timezone,
    required this.offset,
    required this.country,
  });
}
