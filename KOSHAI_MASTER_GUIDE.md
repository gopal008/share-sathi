# KoshAI — Flutter + Firebase + Gemini Master Prompt
### Nepal Stock Market App | Zero-Cost Infrastructure | Production-Ready

---

## 0. YOUR ROLE AND OPERATING PHILOSOPHY

यो एप्लिकेशन एक **20+ वर्षको अनुभव भएको Flutter आर्किटेक्ट र Firebase समाधान इन्जिनियर**को दृष्टिकोणबाट बनाइएको छ।

### मुख्य सिद्धान्तहरू:
- **Production-Grade Code**: कोनै placeholder logic छैन
- **Firebase Spark Budget**: सबै निर्णय free tier को सीमा अनुसार
- **Error Handling**: हरेक function मा proper error handling
- **Offline Support**: Isar cache वाट offline data सेवा

---

## 1. PROJECT IDENTITY

| क्षेत्र | मूल्य |
|---|---|
| **App Name** | ShareSathi |
| **लक्ष्य बाजार** | नेपाल - NEPSE शेयर बजार |
| **प्राथमिक भाषा** | नेपाली (ne) |
| **Platform** | Flutter — Android + iOS |
| **State Management** | Provider / Riverpod |
| **Local DB** | Isar |

---

## 2. FIREBASE SPARK QUOTA

```
Firestore Reads  : 50,000/दिन
Firestore Writes : 20,000/दिन
Storage          : 10 GB
Auth MAU         : 50,000/महिना
```

**नियम**: हरेक Firestore query अघि सोचनुहोस् - के मैले यो डेटा पहिले्नै लोड गरेको cache बाट पा सक्छु?

---

## 3. DIRECTORY STRUCTURE

```
lib/
├── main.dart
├── core/
│   ├── constants/app_colors.dart
│   ├── constants/app_strings.dart
│   ├── theme/app_theme.dart
│   └── helpers/gemini_rate_limiter.dart
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
│       ├── time_zone_service.dart
│       ├── joke_service.dart
│       ├── ipo_service.dart
│       └── market_service.dart
├── presentation/
│   ├── screens/home/
│   ├── screens/ipo_result/
│   ├── screens/news/
│   ├── screens/market/
│   ├── screens/leaderboard/
│   └── screens/tools/
│       ├── digital_clock_screen.dart
│       └── joke_generator_screen.dart
└── shared/widgets/
```

---

## 4. FIRESTORE DATA ARCHITECTURE

```
/market/summary (१ दस्तावेज)
  {
    top5Gainers: [],
    top5Losers: [],
    nepseIndex: "price",
    lastUpdated: timestamp
  }

/ipo/active (१ दस्तावेज)
  {
    items: [
      {
        id, name, type, logo,
        closeDate, isForeignEmploymentQuota
      }
    ]
  }

/news/{newsId}
  {
    title, summary, sourceName,
    sourceUrl, publishedAt,
    category, sentiment
  }

/users/{uid}
  {
    displayName, referralCode,
    referralCount, joinedAt, kycSubmitted
  }

/leaderboard/monthly_{bsYear}_{bsMonth}
  {
    entries: [
      {uid, displayName, referralCount, rank}
    ]
  }
```

---

## 5. SCREEN SPECIFICATIONS

### HOME SCREEN:
- Active IPOs section (cached 1 hour)
- Upcoming IPOs (next 30 days)
- Recently closed IPOs
- Countdown timers
- AdMob banner

### IPO RESULT SCREEN:
- LRN number input
- Direct connection to CDSC website
- Allocation result display
- No server involvement

### NEWS SCREEN:
- Latest news from Firestore
- WebView for full articles
- Every 3rd item: AdMob native ad

### MARKET SCREEN:
- Top 5 Gainers (green)
- Top 5 Losers (red)
- Real-time update (1 Firestore read, 30min cache)

### LEADERBOARD SCREEN:
- Monthly rankings
- Prize pool: 1st=Rs6000, 2nd=Rs3000, 3rd=Rs2000
- Referral points system

---

## 6. GITHUB ACTIONS SCRAPER

**चलाउने समय**: हरेक दिन 09:30 UTC (3:15 PM NST), सूर्य-बिहीबार मात्र

**स्क्र्याप गरिने डेटा**:
- MeroLagani gainers/losers
- ShareSansar NEPSE index
- Active IPOs

**Firestore writes**: 2 writes/दिन (budget मा)?

---

## 7. ADMOB CONFIGURATION

### Test IDs:
```
Android banner  : ca-app-pub-3940256099942544/6300978111
iOS banner      : ca-app-pub-3940256099942544/2934735716
```

### नेपालबाट Payment:
1. Global IME Bank वा NIC Asia मार्फत wire transfer
2. Kathmandu GPO PIN code प्रयोग गर्नुहोस्
3. ३ पटक असफल भएमा document verification

---

## 8. FIREBASE SECURITY RULES

```firestore
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /market/{doc=**} {
      allow read: if true;
      allow write: if false;
    }
    match /ipo/{doc=**} {
      allow read: if true;
      allow write: if false;
    }
    match /users/{userId} {
      allow read, write: if request.auth.uid == userId;
    }
    match /leaderboard/{doc=**} {
      allow read: if request.auth != null;
      allow write: if false;
    }
  }
}
```

---

## 9. GEMINI API INTEGRATION

### Rate Limits:
- 10 requests/minute
- 1,500 requests/day
- Free tier: कुनै क्रेडिट कार्ड आवश्यक छैन

### Use Cases:
1. **News Summarization**: लामो खबरलाई छोटो बनाउने
2. **IPO Analysis**: जोखिम स्तर calculate गर्ने
3. **Portfolio OCR**: MeroShare स्क्रीनशटबाट डेटा निकाल्ने

### Token Bucket Rate Limiter:
```dart
class GeminiRateLimiter {
  static const int _maxTokens = 8;
  static const Duration _refillRate = Duration(seconds: 7);
  int _tokens = _maxTokens;
  DateTime _lastRefill = DateTime.now();

  bool canMakeRequest() {
    _refillTokens();
    if (_tokens > 0) {
      _tokens--;
      return true;
    }
    return false;
  }

  void _refillTokens() {
    final now = DateTime.now();
    final elapsed = now.difference(_lastRefill);
    final tokensToAdd = elapsed.inSeconds ~/ _refillRate.inSeconds;
    if (tokensToAdd > 0) {
      _tokens = (_tokens + tokensToAdd).clamp(0, _maxTokens);
      _lastRefill = now;
    }
  }
}
```

---

## 10. ERROR HANDLING

सबै user-facing errors नेपालीमा:

```dart
NetworkException    → "इन्टरनेट जडान जाँच गर्नुहोस्।"
RateLimitException  → "धेरै अनुरोध भयो। एक मिनेट पछि फेरि प्रयास गर्नुहोस्।"
CdscServerException → "CDSC सर्भर अहिले व्यस्त छ।"
```

---

## 11. NEVER DO LIST

❌ Firebase Cloud Functions (requires Blaze plan)
❌ Loop Firestore reads
❌ Store MeroShare screenshots permanently
❌ Call Gemini without rate limiter
❌ Use Firebase ML
❌ Write functions without error handling
❌ Give financial buy/sell recommendations

---

## 12. GITHUB SECRETS

### अनिवार्य secrets:
```
FIREBASE_SERVICE_ACCOUNT_JSON
GEMINI_API_KEY
ADMOB_ANDROID_APP_ID
ADMOB_IOS_APP_ID
```

---

*ShareSathi - नेपाली शेयर बजारको साथी* 🚀
