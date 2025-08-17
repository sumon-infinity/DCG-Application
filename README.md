# DCG - Daffodil CrisisGuard

**Stay Alert, Stay Safe** 🚨

A comprehensive crisis management and emergency response Flutter application designed for Daffodil International University (DIU). The app provides instant access to emergency services, safety resources, and crisis support for students, faculty, and staff.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Material Design](https://img.shields.io/badge/Material_Design-757575?style=for-the-badge&logo=material-design&logoColor=white)

## 🎯 Overview

DCG (Daffodil CrisisGuard) is a complete emergency management platform that enables users to:
- Send instant emergency alerts to contacts and authorities
- Access medical emergency services and nearby hospitals
- Connect with mental health and psychology services
- Find safe zones and emergency shelters
- Make emergency calls with one-touch dialing
- Access crisis management resources and FAQs

## ✨ Features

### 🚨 Emergency Services
- **Emergency Alert System**: Instant broadcasting of emergency situations
- **Emergency Call Screen**: One-touch dialing to 911, local emergency services
- **Medical Alert**: Send medical condition alerts with detailed information
- **Safe Zone Finder**: Locate nearby safe places categorized by type

### 🏥 Medical Services  
- **Nearest Medical Services**: Find hospitals and medical facilities
- **Health Condition Tracker**: Medical emergency condition selection
- **Emergency Medical Information**: Quick access to critical medical data

### 🧠 Mental Health Support
- **Psychology Services**: Professional counseling and therapy services
- **Crisis Intervention**: 24/7 mental health crisis support
- **Appointment Booking**: Schedule therapy sessions
- **Mental Health Assessment**: Counseling forms and evaluations

### 📞 Communication
- **Emergency Contacts**: Quick access to university security, police, medical services
- **FAQ & Help Center**: Searchable crisis management resources
- **Real-time Alerts**: Push notifications for emergency situations

### 👤 User Management
- **Profile Management**: Personal information and emergency contacts
- **Settings**: App preferences and notification settings
- **Authentication**: Secure login with university credentials

## 🏗️ Technical Architecture

### Frontend
- **Framework**: Flutter 3.x
- **Language**: Dart
- **UI Design**: Material Design 3
- **State Management**: BLoC Pattern (flutter_bloc)
- **Routing**: go_router for declarative navigation
- **Animations**: Custom animations with AnimationController

### Key Dependencies
```yaml
dependencies:
  flutter_bloc: ^8.1.3      # State management
  go_router: ^14.0.2        # Navigation
  lucide_icons: ^0.257.0    # Modern icon set
  url_launcher: ^6.3.1      # Phone calls and external links
  shared_preferences: ^2.2.2 # Local storage
  loading_animation_widget: ^1.2.1 # Loading animations
```

### Project Structure
```
lib/
├── app/
│   ├── router/           # Navigation configuration
│   └── theme/           # Material Design theme
├── features/
│   ├── auth/            # Authentication & onboarding
│   ├── emergency/       # Emergency alerts & services
│   ├── medical/         # Medical services & alerts
│   ├── psychology/      # Mental health services
│   ├── profile/         # User profile management
│   └── help/           # FAQ & support
├── shared/
│   ├── services/        # Mock data & API services
│   └── widgets/        # Reusable UI components
└── main.dart           # App entry point
```

### State Management
- **BLoC Architecture**: Separate business logic from UI
- **Event-Driven**: Reactive state updates
- **Immutable States**: Predictable state management
- **Repository Pattern**: Abstracted data access

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- VS Code or Android Studio
- Chrome (for web development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/sumon-infinity/DCG-Application.git
   cd DCG-Application/dcg
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   # For web (recommended for development)
   flutter run -d chrome

   # For mobile
   flutter run
   ```

### Development Setup

1. **Enable web support** (if not already enabled)
   ```bash
   flutter config --enable-web
   ```

2. **Check available devices**
   ```bash
   flutter devices
   ```

3. **Run with hot reload**
   ```bash
   flutter run --hot
   ```

## 📱 Supported Platforms

- ✅ **Web** (Chrome, Firefox, Safari, Edge)
- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 11.0+)
- ✅ **macOS** (macOS 10.14+)
- ✅ **Windows** (Windows 10+)
- ✅ **Linux** (Ubuntu 18.04+)

## 🎨 UI/UX Design

### Design Principles
- **Material Design 3**: Modern, accessible design system
- **Crisis-First UX**: Prioritizes emergency features
- **One-Touch Access**: Critical actions within 1-2 taps
- **Clear Visual Hierarchy**: Easy to use under stress
- **Responsive Design**: Works on all screen sizes

### Color Scheme
- **Primary**: Emerald Green (`#059669`) - Trust and safety
- **Emergency**: Red (`#DC2626`) - Urgent actions
- **Medical**: Blue (`#2563EB`) - Medical services
- **Mental Health**: Purple (`#7C3AED`) - Psychology services

### Typography
- **Font Family**: Inter (System fonts fallback)
- **Headings**: Bold weights for emphasis
- **Body Text**: Regular weight for readability

## 📊 Data Management

### Mock Data System
The app uses a centralized JSON-based mock data system for easy content management:

```json
{
  "app_config": { ... },
  "emergency_contacts": [ ... ],
  "medical_conditions": [ ... ],
  "faq": [ ... ],
  "hospitals": [ ... ],
  "police_stations": [ ... ]
}
```

**Location**: `/assets/mock_data.json`

### Data Services
- **MockDataService**: Handles all data operations
- **Cached Loading**: Efficient data retrieval
- **Error Handling**: Graceful fallbacks
- **Hot Reload**: Development-friendly updates

## 🧪 Testing

### Running Tests
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

### Test Coverage
- Unit Tests: BLoC logic and data services
- Widget Tests: UI component behavior
- Integration Tests: End-to-end user flows

## 🔒 Security & Privacy

### Data Protection
- **Local Storage Only**: No sensitive data transmitted
- **Encrypted Preferences**: Secure local data storage
- **Permission-Based**: Only requests necessary permissions

### Emergency Privacy
- **Opt-in Sharing**: User controls emergency contact sharing
- **Anonymous Alerts**: Optional anonymous emergency reporting
- **Data Minimization**: Only essential data collection

## 🚀 Deployment

### Web Deployment
```bash
# Build for web
flutter build web

# Deploy to hosting (Firebase, Netlify, etc.)
firebase deploy
```

### Mobile App Deployment
```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release
```

### Environment Configuration
- **Development**: Hot reload enabled, debug features
- **Production**: Optimized builds, error reporting
- **Staging**: Testing environment with production data

## 🤝 Contributing

### Development Workflow
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Code Style
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `flutter format` for consistent formatting
- Run `flutter analyze` before committing

### Commit Convention
```
feat: add new emergency alert feature
fix: resolve navigation issue in profile
docs: update README with deployment instructions
style: format code according to style guide
```

## 📈 Performance

### Optimization Features
- **Lazy Loading**: Screens loaded on demand
- **Image Optimization**: Compressed assets
- **Tree Shaking**: Unused code elimination
- **Code Splitting**: Efficient bundle loading

### Performance Monitoring
- Flutter DevTools integration
- Performance profiling
- Memory usage optimization
- Battery usage optimization

## 🐛 Troubleshooting

### Common Issues

**Build Errors**
```bash
flutter clean
flutter pub get
flutter run
```

**Web CORS Issues**
```bash
flutter run -d chrome --web-renderer html
```

**Hot Reload Not Working**
```bash
flutter run --hot
```

## 📞 Emergency Contacts (Demo)

- **University Security**: +880-2-9138234
- **National Emergency**: 999
- **Medical Emergency**: 911
- **Crisis Helpline**: 16263
- **Women & Child Helpline**: 109

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Development Team

**Daffodil International University**
- Crisis Management Team
- IT Department
- Student Services

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- Material Design team for design system
- Lucide Icons for beautiful icon set
- DIU Administration for support and guidance
- Emergency services and first responders

---

**For emergency support, always call your local emergency number (911, 999) immediately.**

**This app is a supplementary tool and should not replace direct emergency services contact.**

---

*Built with ❤️ by DIU Development Team*
