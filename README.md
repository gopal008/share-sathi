# ShareSathi - नेपाली शेयर बजार App

🇳🇵 **ShareSathi** - शेयर बजारको साथी

## विवरण

ShareSathi एक सम्पूर्ण नेपाली शेयर बजार एप्लिकेशन हो जो निम्नलिखित सुविधाहरू प्रदान गर्छ:

### मुख्य फीचरहरु:

1. **Home** - सक्रिय र आसन्न IPOs को विवरण
2. **IPO Result** - LRN नम्बर जाँच गरेर परिणाम हेर्न
3. **News** - शेयर बजार सम्बन्धित समाचार
4. **Market** - Top Gainers र Losers
5. **Leaderboard** - मासिक प्रतियोगिता र पुरस्कार

## तकनीकी ब्यौरा

### Frontend
- **Framework**: Flutter (Dart)
- **UI Design**: Material Design 3
- **Fonts**: Mukta (नेपाली) + Roboto (English)

### Backend
- **Database**: Firebase Firestore
- **Authentication**: Firebase Auth
- **Notifications**: Firebase Cloud Messaging
- **Hosting**: Firebase Hosting

### Integration
- **AI**: Google Gemini 2.5 API
- **Ads**: Google AdMob
- **Analytics**: Firebase Analytics

## सुरुवात गर्न

### आवश्यकताएं
- Flutter 3.0+
- Dart 3.0+
- Firebase Project
- AdMob Account

### Installation

```bash
git clone https://github.com/gopal008/share-sathi.git
cd share-sathi
flutter pub get
flutterfire configure
flutter run
```

## फोल्डर संरचना

```
lib/
├── main.dart
├── core/
│   ├── constants/
│   ├── theme/
│   └── utils/
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
├── presentation/
│   ├── home/
│   ├── ipo_result/
│   ├── news/
│   ├── market/
│   └── leaderboard/
└── shared/
    └── widgets/
```

## Contributors

👤 **Gopal** - Initial work

## License

MIT License - तपाईं यो परियोजनालाई स्वतन्त्रतापूर्वक प्रयोग गर्न सक्नुहुन्छ।

## सहायता र संपर्क

कुनै प्रश्न वा सुझाव भएमा issues खोल्नुहोस।

---

*शेयर बजारको साथी - ShareSathi* 🚀
