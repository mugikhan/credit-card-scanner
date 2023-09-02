# Flutter credit card scanner

A flutter mobile application for saving and storing credit card details. It also adds the ability to scan a card and autofill in the details required.

## Generate database models
```dart
flutter pub run build_runner build --delete-conflicting-outputs
```

# Run the app locally
```dart
1. flutter pub run build_runner build --delete-conflicting-outputs
2. flutter devices
--------------------
3 connected devices:

Mughees’ iPhone (mobile) • 00008110-0009301E0252801E • ios            • iOS 16.6 20G75
macOS (desktop)          • macos                     • darwin-arm64   • macOS 13.0 22A8380 darwin-arm64
Chrome (web)             • chrome                    • web-javascript • Google Chrome 116.0.5845.140
--------------------
3. flutter run -d "device name or id"
```