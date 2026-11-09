# J’Donuts Customer App

Flutter take-home project for Android and iOS. The current milestone includes offline catalog storage and the local registration and login flow.

## Development setup

Use Flutter **3.47.9** with Dart **3.13.7**. Install the Android SDK and an Android emulator for Android, or Xcode and an iOS Simulator runtime for iOS.

```sh
flutter --version
flutter doctor -v
flutter pub get
flutter devices
flutter run -d DEVICE_ID
```

Replace `DEVICE_ID` with the emulator or simulator ID from `flutter devices`.

## Build and check

```sh
flutter analyze
flutter test
flutter build apk --release
flutter build ios --simulator --debug
```

The Android APK is at `build/app/outputs/flutter-apk/app-release.apk`. The iOS Simulator bundle is at `build/ios/iphonesimulator/Runner.app`. On macOS, package the simulator bundle with:

```sh
ditto -c -k --keepParent build/ios/iphonesimulator/Runner.app build/ios/JDonuts-Simulator.zip
```

## Local data

Drift creates the SQLite schema and seeds it from `assets/data/catalog.json` on first open. Catalog, Home, and Rewards repositories read SQLite. Home and Rewards read the same member record. Riverpod provides the database and repositories so tests can use a separate database.

After changing the Drift schema, regenerate the checked-in Dart file with `dart run build_runner build`.

## Demo authentication

Register with a Myanmar mobile number and use **123456** for the OTP. The demo saves users in SQLite and the current session in platform secure storage. Use **Settings → Log out** to try the returning user flow.

Run the device auth flow test with `flutter test integration_test/app_flow_test.dart -d DEVICE_ID`.

See [PROJECT_PLAN.md](PROJECT_PLAN.md) for milestone status and acceptance checks.
