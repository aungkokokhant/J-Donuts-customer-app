# J’Donuts Customer App

An offline-first Flutter demo for Android and iOS. Register or sign in with a
Myanmar mobile number, browse the donut catalog, add items to your cart, and
see your membership progress and challenges in Rewards.

## Run the app

Use **Flutter 3.47.9 stable** with its bundled **Dart 3.13.7**. Set up the
Android SDK and an emulator for Android, or Xcode and an iOS Simulator runtime
on macOS for iOS. Start the emulator or simulator before running these commands
from the repository root.

```sh
flutter --version
flutter doctor -v
flutter pub get --enforce-lockfile
flutter devices
flutter run -d DEVICE_ID
```

Replace `DEVICE_ID` with the ID shown by `flutter devices`. If you run from
Android Studio, point its Flutter plugin at the same SDK.

## Try the demo

1. Tap **Let’s Get Started**, enter a valid Myanmar mobile number, and use
   **123456** as the demo OTP. Complete registration and tap **Let’s Explore**.
2. Open **Settings → Log out**, then sign in with the same number and OTP.
   Once verified, an existing account opens Home directly.
3. Open **Coconut Donut** from **Popular** and change the quantity. The button
   shows the updated total. Add it to the cart and reopen it from
   **Settings → Cart**.
4. Open **Reward** and switch between **Eat more earn more** and **Gift**.
5. Enable airplane mode and turn off Wi-Fi. Repeat the flow to verify local
   authentication, catalog images, the cart, and Rewards.

English is the default. **Settings → Language** lets you select English,
မြန်မာ, or the device language. The app remembers your choice. Demo catalog
copy remains in English.

## Architecture and state management

| Location | Responsibility |
| --- | --- |
| [`lib/app/`](lib/app/) | Riverpod providers, reachability, shared theme and motion, and `go_router` with session guards |
| [`lib/features/`](lib/features/) | Auth, Home, Product, Rewards, and Cart, each with presentation, domain, and data layers |
| [`lib/core/`](lib/core/) | Drift schema and migrations, shared models, typed results, and catalog widgets |
| [`assets/data/catalog.json`](assets/data/catalog.json) | Bundled catalog, membership, and challenge data |
| [`lib/l10n/`](lib/l10n/) | English and Burmese UI strings generated from ARB files |

Riverpod keeps asynchronous loading, retry, and refresh state scoped to each
catalog section. It also supplies repositories through dependency injection,
so widget tests can substitute controlled data using provider overrides
without changing the screens. The pure-Dart domain defines the repository
contracts and validation rules. The data layer implements those contracts with
Drift and platform secure storage. The router guards signed-in routes,
including `/product/:id`.

## Offline data

On first launch, Drift seeds SQLite from the bundled JSON in a transaction.
SQLite is the source of truth for Home, Product Detail, and Rewards.

- **Membership.** Home and Rewards watch the same `memberProfileProvider`,
  which reads the single `demo` member row. Both use the same Silver tier and
  500 points remaining to Gold. Rewards also displays the row’s 680,000 total
  points. Home uses the signed-in user’s first name as its greeting when
  available.
- **Product.** Coconut Donut uses ID `p_coconut`, code `JD022123`, a price of
  **3,200 MMK**, the New badge, and a null discount. Its description and image
  key come from SQLite. The image key resolves to bundled artwork so the product
  image is available even on an offline first launch.
- **Refresh and images.** An HTTPS reachability check complements
  `connectivity_plus` and rechecks every 30 seconds on active catalog screens.
  Reconnection and pull-to-refresh reload local data. Each Home rail has its
  own skeleton, empty, and error states. Images have placeholders and error
  states. Remote image sources use a disk cache when present.
- **Session and cart.** The demo stores accounts and per-account carts in
  SQLite. It stores the session identifier in platform secure storage so
  relaunching can restore the signed-in state.

After changing the Drift schema, regenerate the checked-in Dart file with
`dart run build_runner build`.

## Motion and accessibility

The app animates the onboarding and Welcome entrances, registration steps and
progress ring, OTP errors, and button press and loading states. Home uses
skeleton shimmer and an autoplaying carousel. Product Detail uses a Hero
transition and an animated quantity. Rewards animates the points ring, tier
progress, challenge artwork, and tab transitions. The bottom navigation uses
an animated selection pill. Reduce Motion shortens or skips transitions and
stops carousel autoplay.

The bundled fonts are [Abel](assets/fonts/Abel-OFL.txt),
[ADLaM Display](assets/fonts/ADLaMDisplay-OFL.txt), and
[Noto Sans Myanmar](assets/fonts/NotoSansMyanmar-OFL.txt), distributed under
the SIL Open Font License. Catalog artwork uses AI-generated demo images.

## Verify and build

```sh
flutter analyze
flutter test
flutter test integration_test/app_flow_test.dart -d DEVICE_ID
```

For the Android offline integration run, enable airplane mode, turn off Wi-Fi,
and append `--dart-define=EXPECT_OFFLINE=true` to the integration command.
[GitHub Actions](https://github.com/aungkokokhant/J-Donuts-customer-app/actions/workflows/flutter-ci.yml)
runs the analyzer and unit and widget tests with the checked-in lockfile.

Build the packages sequentially. If the Android release build reports an
integration-test plugin error after device tests, run `flutter clean` and
`flutter pub get --enforce-lockfile` before building again.

```sh
flutter build apk --release
flutter build ios --simulator --debug
ditto -c -k --keepParent build/ios/iphonesimulator/Runner.app build/ios/JDonuts-Simulator.zip
```

The Android package is `build/app/outputs/flutter-apk/app-release.apk`. The
iOS archive is `build/ios/JDonuts-Simulator.zip` and contains a Simulator
`Runner.app`. The submission walkthrough runs about 3 minutes 14 seconds and
shows the same flow online and in airplane mode.

## Scope and time spent

- Authentication, checkout, social sign-in, and unused navigation destinations
  are demo flows. Catalog refresh reads from SQLite.
- The Redmi K30 profile run showed some frames exceeding 16.67 ms during
  Home and Rewards transitions. The jank-free 60 fps target remains open.
- About 2.5 hours were logged for initial implementation and verification.
  UI polish, physical-device checks, and packaging took additional time.
