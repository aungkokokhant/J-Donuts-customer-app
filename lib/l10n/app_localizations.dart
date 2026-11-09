import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'J’Donuts'**
  String get appTitle;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Round food for\nevery mood'**
  String get onboardingTitle;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Let’s get started'**
  String get getStarted;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccount;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @apple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get apple;

  /// No description provided for @facebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'This option is not available in the demo.'**
  String get notAvailable;

  /// No description provided for @legalPrefix.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you acknowledge that you have read and agree to our'**
  String get legalPrefix;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get terms;

  /// No description provided for @andWord.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get andWord;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy;

  /// No description provided for @phoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get phoneTitle;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneLabel;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid Myanmar phone number.'**
  String get invalidPhone;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @verifyTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your number'**
  String get verifyTitle;

  /// No description provided for @verifyMessage.
  ///
  /// In en, this message translates to:
  /// **'We’ve sent a 6-digit OTP to {phone}'**
  String verifyMessage(String phone);

  /// No description provided for @otpLabel.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get otpLabel;

  /// No description provided for @otpWrong.
  ///
  /// In en, this message translates to:
  /// **'That code is incorrect. Try again.'**
  String get otpWrong;

  /// No description provided for @otpLocked.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Wait until you can resend the code.'**
  String get otpLocked;

  /// No description provided for @otpMissing.
  ///
  /// In en, this message translates to:
  /// **'Didn’t receive the code?'**
  String get otpMissing;

  /// No description provided for @resendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in {remaining}'**
  String resendIn(String remaining);

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @unknownPhone.
  ///
  /// In en, this message translates to:
  /// **'This number hasn’t registered yet.'**
  String get unknownPhone;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @alreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'This number is already registered.'**
  String get alreadyRegistered;

  /// No description provided for @authError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get authError;

  /// No description provided for @nameTitle.
  ///
  /// In en, this message translates to:
  /// **'What’s your name?'**
  String get nameTitle;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @invalidName.
  ///
  /// In en, this message translates to:
  /// **'Use 1–50 letters and spaces.'**
  String get invalidName;

  /// No description provided for @birthTitle.
  ///
  /// In en, this message translates to:
  /// **'What’s your date of birth?'**
  String get birthTitle;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @invalidBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid date. You must be at least 13.'**
  String get invalidBirthDate;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the\nworld of J’Donuts'**
  String get welcomeTitle;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Let’s explore'**
  String get explore;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @productUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This product is unavailable.'**
  String get productUnavailable;

  /// No description provided for @memberTier.
  ///
  /// In en, this message translates to:
  /// **'{tier} member'**
  String memberTier(String tier);

  /// No description provided for @pointsToTier.
  ///
  /// In en, this message translates to:
  /// **'{points} points left to become {tier}'**
  String pointsToTier(String points, String tier);

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @rewards.
  ///
  /// In en, this message translates to:
  /// **'Reward'**
  String get rewards;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @offlineMessage.
  ///
  /// In en, this message translates to:
  /// **'You’re offline. Showing saved data.'**
  String get offlineMessage;

  /// No description provided for @nearbyShops.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{There is 1 J’Donut shop near you.} other{There are {count} J’Donut shops near you.}}'**
  String nearbyShops(int count);

  /// No description provided for @exploreNow.
  ///
  /// In en, this message translates to:
  /// **'Explore now'**
  String get exploreNow;

  /// No description provided for @orderOnline.
  ///
  /// In en, this message translates to:
  /// **'Order online'**
  String get orderOnline;

  /// No description provided for @newLabel.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newLabel;

  /// No description provided for @discountLabel.
  ///
  /// In en, this message translates to:
  /// **'{percent}% off'**
  String discountLabel(int percent);

  /// No description provided for @priceMmk.
  ///
  /// In en, this message translates to:
  /// **'{price} MMK'**
  String priceMmk(String price);

  /// No description provided for @whatsThis.
  ///
  /// In en, this message translates to:
  /// **'What’s this?'**
  String get whatsThis;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addToCart;

  /// No description provided for @addedToCart.
  ///
  /// In en, this message translates to:
  /// **'Added to cart'**
  String get addedToCart;

  /// No description provided for @decreaseQuantity.
  ///
  /// In en, this message translates to:
  /// **'Decrease quantity'**
  String get decreaseQuantity;

  /// No description provided for @increaseQuantity.
  ///
  /// In en, this message translates to:
  /// **'Increase quantity'**
  String get increaseQuantity;

  /// No description provided for @dataError.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t load this section.'**
  String get dataError;

  /// No description provided for @emptySection.
  ///
  /// In en, this message translates to:
  /// **'Nothing to show here yet.'**
  String get emptySection;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @rewardsTitle.
  ///
  /// In en, this message translates to:
  /// **'J’ Donuts Rewards'**
  String get rewardsTitle;

  /// No description provided for @rewardsBadge.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewardsBadge;

  /// No description provided for @totalPoints.
  ///
  /// In en, this message translates to:
  /// **'Total points'**
  String get totalPoints;

  /// No description provided for @currentTier.
  ///
  /// In en, this message translates to:
  /// **'You’re here now'**
  String get currentTier;

  /// No description provided for @futureTier.
  ///
  /// In en, this message translates to:
  /// **'You’ll be here soon'**
  String get futureTier;

  /// No description provided for @nextTierRemaining.
  ///
  /// In en, this message translates to:
  /// **'{points} pts remaining to become {tier}'**
  String nextTierRemaining(String points, String tier);

  /// No description provided for @silver.
  ///
  /// In en, this message translates to:
  /// **'Silver'**
  String get silver;

  /// No description provided for @gold.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get gold;

  /// No description provided for @platinum.
  ///
  /// In en, this message translates to:
  /// **'Platinum'**
  String get platinum;

  /// No description provided for @earnTab.
  ///
  /// In en, this message translates to:
  /// **'Eat more earn more'**
  String get earnTab;

  /// No description provided for @giftTab.
  ///
  /// In en, this message translates to:
  /// **'Gift'**
  String get giftTab;

  /// No description provided for @noGifts.
  ///
  /// In en, this message translates to:
  /// **'Gifts will appear here.'**
  String get noGifts;

  /// No description provided for @earn.
  ///
  /// In en, this message translates to:
  /// **'Earn'**
  String get earn;

  /// No description provided for @rewardPoints.
  ///
  /// In en, this message translates to:
  /// **'{points} pts'**
  String rewardPoints(String points);

  /// No description provided for @challengeProgress.
  ///
  /// In en, this message translates to:
  /// **'{done}/{goal}'**
  String challengeProgress(int done, int goal);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
