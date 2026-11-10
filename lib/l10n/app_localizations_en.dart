// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'J’Donuts';

  @override
  String get onboardingTitle => 'Round food for\nevery mood';

  @override
  String get getStarted => 'Let’s get started';

  @override
  String get haveAccount => 'Already have an account?';

  @override
  String get logIn => 'Log in';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get facebook => 'Facebook';

  @override
  String get notAvailable => 'This option is not available in the demo.';

  @override
  String get legalPrefix =>
      'By continuing, you acknowledge that you have read and agree to our';

  @override
  String get terms => 'Terms of Use';

  @override
  String get andWord => 'and';

  @override
  String get privacy => 'Privacy Policy';

  @override
  String get phoneTitle => 'Enter your phone number';

  @override
  String get phoneLabel => 'Phone number';

  @override
  String get invalidPhone => 'Enter a valid Myanmar phone number.';

  @override
  String get continueLabel => 'Continue';

  @override
  String get verifyTitle => 'Verify your number';

  @override
  String verifyMessage(String phone) {
    return 'We’ve sent a 6-digit OTP to $phone';
  }

  @override
  String get otpLabel => 'Verification code';

  @override
  String get otpWrong => 'That code is incorrect. Try again.';

  @override
  String get otpLocked =>
      'Too many attempts. Wait until you can resend the code.';

  @override
  String get otpMissing => 'Didn’t receive the code?';

  @override
  String resendIn(String remaining) {
    return 'Resend in $remaining';
  }

  @override
  String get resend => 'Resend';

  @override
  String get unknownPhone => 'This number hasn’t registered yet.';

  @override
  String get register => 'Register';

  @override
  String get authError => 'Something went wrong. Please try again.';

  @override
  String get nameTitle => 'What’s your name?';

  @override
  String get firstName => 'First name';

  @override
  String get lastName => 'Last name';

  @override
  String get invalidName => 'Use 1–50 letters and spaces.';

  @override
  String get birthTitle => 'What’s your date of birth?';

  @override
  String get month => 'Month';

  @override
  String get day => 'Day';

  @override
  String get year => 'Year';

  @override
  String get invalidBirthDate => 'Enter a valid date. You must be at least 13.';

  @override
  String get welcomeTitle => 'Welcome to the\nworld of J’Donuts';

  @override
  String get explore => 'Let’s explore';

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';

  @override
  String get languageTitle => 'Language';

  @override
  String get systemLanguage => 'Device language';

  @override
  String get languageUpdateFailed =>
      'Couldn’t save your language. Please try again.';

  @override
  String get logOut => 'Log out';

  @override
  String get productUnavailable => 'This product is unavailable.';

  @override
  String memberTier(String tier) {
    return '$tier member';
  }

  @override
  String pointsToTier(String points, String tier) {
    return '$points points left to become $tier';
  }

  @override
  String get notifications => 'Notifications';

  @override
  String get rewards => 'Reward';

  @override
  String get menu => 'Menu';

  @override
  String get wallet => 'Wallet';

  @override
  String get offlineMessage => 'You’re offline. Showing saved data.';

  @override
  String nearbyShops(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'There are $count J’Donut shops near you.',
      one: 'There is 1 J’Donut shop near you.',
    );
    return '$_temp0';
  }

  @override
  String get exploreNow => 'Explore now';

  @override
  String get orderOnline => 'Order online';

  @override
  String get seasonalSpecials => 'Seasonal specials';

  @override
  String get popular => 'Popular';

  @override
  String get orderAgain => 'Order again';

  @override
  String get newLabel => 'New';

  @override
  String discountLabel(int percent) {
    return '$percent% off';
  }

  @override
  String priceMmk(String price) {
    return '$price MMK';
  }

  @override
  String get whatsThis => 'What’s this?';

  @override
  String get addToCart => 'Add to cart';

  @override
  String get addedToCart => 'Added to cart';

  @override
  String get cartTitle => 'Cart';

  @override
  String get viewCart => 'View cart';

  @override
  String get cartEmpty => 'Your cart is empty.';

  @override
  String get cartTotal => 'Total';

  @override
  String get cartUpdateFailed => 'Couldn’t update your cart. Please try again.';

  @override
  String get removeFromCart => 'Remove from cart';

  @override
  String get decreaseQuantity => 'Decrease quantity';

  @override
  String get increaseQuantity => 'Increase quantity';

  @override
  String get dataError => 'Couldn’t load this section.';

  @override
  String get emptySection => 'Nothing to show here yet.';

  @override
  String get retry => 'Retry';

  @override
  String get rewardsTitle => 'J’ Donuts Rewards';

  @override
  String get rewardsBadge => 'Rewards';

  @override
  String get totalPoints => 'Total points';

  @override
  String get currentTier => 'You’re here now';

  @override
  String get futureTier => 'You’ll be here soon';

  @override
  String nextTierRemaining(String points, String tier) {
    return '$points pts remaining to become $tier';
  }

  @override
  String get bronze => 'Bronze';

  @override
  String get silver => 'Silver';

  @override
  String get gold => 'Gold';

  @override
  String get platinum => 'Platinum';

  @override
  String get earnTab => 'Eat more earn more';

  @override
  String get giftTab => 'Gift';

  @override
  String get noGifts => 'Gifts will appear here.';

  @override
  String get earn => 'Earn';

  @override
  String rewardPoints(String points) {
    return '$points pts';
  }

  @override
  String challengeProgress(int done, int goal) {
    return '$done/$goal';
  }
}
