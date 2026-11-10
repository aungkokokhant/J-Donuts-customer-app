# J’Donuts Customer App

Flutter take-home project for Android and iOS. The app includes local authentication, the offline Home catalog, Product Detail, and animated Rewards.

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
In Android Studio, point the Flutter plugin at the same SDK directory so it uses
the bundled Dart version.

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

## Architecture

| Folder | Responsibility |
| --- | --- |
| `lib/app/` | Router and session guard, Riverpod providers, reachability, shared theme and motion |
| `lib/features/{auth,home,product,rewards}/presentation/` | Screens, interactions and feature state |
| `lib/features/{auth,home,product,rewards}/domain/` | Pure Dart models, validation and repository contracts |
| `lib/features/{auth,home,product,rewards}/data/` | Local implementations of the domain contracts |
| `lib/core/` | Shared Drift database, typed results, member model and catalog widgets |
| `assets/data/` and `lib/l10n/` | Catalog seed and English UI strings |

Riverpod provides feature state and dependency injection. The screens watch
independent async providers for catalog sections, while tests override repository
providers to exercise the same UI with controlled data.

## Local data

Drift creates the SQLite schema and seeds it from `assets/data/catalog.json` on first open. Catalog, Home, and Rewards repositories read SQLite. Home and Rewards read the same member record. Riverpod provides the database and repositories so tests can use a separate database. Donut cutouts and other catalog artwork are bundled as local assets. For remote images the image widget uses a disk cache.

Home loads the section list and then reads each product rail separately.
Seasonal Specials, Popular, and Order Again each have loading, empty, and error
states. Retry reloads the selected rail. Home uses an HTTPS reachability probe
for its offline banner and refreshes the catalog from SQLite when connectivity
returns or the user pulls to refresh.

After changing the Drift schema, regenerate the checked-in Dart file with `dart run build_runner build`.

## Demo authentication

Register with a Myanmar mobile number and use **123456** for the OTP. The demo saves users in SQLite and the current session in platform secure storage. Use **Settings → Log out** to try the returning user flow.

Run the device registration, product, and rewards flow test with `flutter test integration_test/app_flow_test.dart -d DEVICE_ID`. For Android offline verification, enable airplane mode, turn Wi-Fi off and add `--dart-define=EXPECT_OFFLINE=true`.

See [PROJECT_PLAN.md](PROJECT_PLAN.md) for milestone status and acceptance checks.

## Motion

The app uses staggered onboarding and Welcome entrances, slide transitions and
an animated registration ring, press and loading feedback, and an OTP shake.
Home uses shimmer and an autoplaying carousel. Product detail uses an image
Hero and an animated quantity. Rewards uses a painted points ring with a count-up,
tier reveal, challenge progress artwork, sliding tabs and a sliding navigation
pill. Reduce Motion shortens or skips these effects and stops carousel autoplay.

The submission build uses Abel Regular for body text, labels and fields, and ADLaM
Display Regular for display text and primary buttons. Both are distributed
under the SIL Open Font License. See [Abel-OFL.txt](assets/fonts/Abel-OFL.txt)
and [ADLaMDisplay-OFL.txt](assets/fonts/ADLaMDisplay-OFL.txt).

Donut, coffee, bakery, assortment and member photographs are original
AI-generated demo assets bundled for offline display. The member portrait is fictional.

## Scope and time spent

- Authentication and OTP are local demo flows. Checkout, the extra navigation
  items and social sign-in show demo feedback.
- Catalog refresh reads local data. The app has no mock server or persistent cart.
- The walkthrough covers registration, logout, login, Home, Product Detail
  and Rewards on the Android emulator, online and in airplane mode. An
  earlier release APK was also verified after an offline relaunch on the
  Redmi K30.
- On a physical Redmi K30 (Android 11, 120 Hz display mode), a profile
  retest measured five cold Home launches and Rewards entries before and
  after the rendering changes. Cold Home frames over the 16.67 ms budget
  fell from 29/428 to 24/467. The longest Rewards frame fell from 44.70 ms
  to 31.20 ms, with 16/511 frames over budget. The physical-device jank-free
  target remains open.
- The Home section Retry update passed the compact Android emulator and iOS
  Simulator flows. Its physical-device retest is pending a USB debugging
  connection to the Redmi K30.
- Approximately 2.5 hours logged for initial implementation and verification,
  followed by UI polish and a physical-device audit.
