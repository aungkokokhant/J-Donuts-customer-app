// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'J’Donuts';

  @override
  String get onboardingTitle => 'စိတ်ခံစားချက်တိုင်းအတွက်\nဒိုးနတ်လေးတွေ';

  @override
  String get getStarted => 'စလိုက်ရအောင်';

  @override
  String get haveAccount => 'အကောင့်ရှိပြီးသားလား။';

  @override
  String get logIn => 'ဝင်ရန်';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get facebook => 'Facebook';

  @override
  String get notAvailable => 'ဒီစမ်းသပ်ဗားရှင်းမှာ အသုံးပြုလို့ မရသေးပါ။';

  @override
  String get legalPrefix =>
      'ဆက်သွားခြင်းဖြင့် ဖတ်ရှုပြီး သဘောတူကြောင်း အတည်ပြုသည့် မူဝါဒများမှာ';

  @override
  String get terms => 'အသုံးပြုမှု စည်းမျဉ်းများ';

  @override
  String get andWord => 'နှင့်';

  @override
  String get privacy => 'ကိုယ်ရေးအချက်အလက် မူဝါဒ';

  @override
  String get phoneTitle => 'ဖုန်းနံပါတ် ထည့်ပါ';

  @override
  String get phoneLabel => 'ဖုန်းနံပါတ်';

  @override
  String get invalidPhone => 'မှန်ကန်သော မြန်မာဖုန်းနံပါတ် ထည့်ပါ။';

  @override
  String get continueLabel => 'ဆက်သွားရန်';

  @override
  String get verifyTitle => 'ဖုန်းနံပါတ် အတည်ပြုပါ';

  @override
  String verifyMessage(String phone) {
    return '$phone သို့ ဂဏန်း ၆ လုံးပါ OTP ပို့ထားပါသည်။';
  }

  @override
  String get otpLabel => 'အတည်ပြုကုဒ်';

  @override
  String get otpWrong => 'ကုဒ် မမှန်ပါ။ ထပ်စမ်းကြည့်ပါ။';

  @override
  String get otpLocked =>
      'အကြိမ်များစွာ စမ်းပြီးပါပြီ။ ကုဒ်ပြန်တောင်းနိုင်သည်အထိ စောင့်ပါ။';

  @override
  String get otpMissing => 'ကုဒ် မရသေးဘူးလား။';

  @override
  String resendIn(String remaining) {
    return '$remaining ပြီးလျှင် ပြန်ပို့နိုင်မည်';
  }

  @override
  String get resend => 'ပြန်ပို့ရန်';

  @override
  String get unknownPhone => 'ဤနံပါတ်ဖြင့် အကောင့်ဖွင့်ထားခြင်း မရှိသေးပါ။';

  @override
  String get register => 'အကောင့်ဖွင့်ရန်';

  @override
  String get authError => 'အမှားတစ်ခု ဖြစ်သွားပါသည်။ ထပ်စမ်းကြည့်ပါ။';

  @override
  String get nameTitle => 'နာမည် ဘယ်လိုခေါ်လဲ။';

  @override
  String get firstName => 'အမည်';

  @override
  String get lastName => 'နောက်ဆုံးအမည်';

  @override
  String get invalidName => 'စာလုံး ၁ လုံးမှ ၅၀ အထိနှင့် နေရာလွတ်သာ သုံးပါ။';

  @override
  String get birthTitle => 'မွေးနေ့ ဘယ်နေ့လဲ။';

  @override
  String get month => 'လ';

  @override
  String get day => 'ရက်';

  @override
  String get year => 'နှစ်';

  @override
  String get invalidBirthDate =>
      'မှန်ကန်သော မွေးသက္ကရာဇ် ထည့်ပါ။ အနည်းဆုံး ၁၃ နှစ် ပြည့်ရပါမည်။';

  @override
  String get welcomeTitle => 'J’Donuts မှ\nကြိုဆိုပါတယ်';

  @override
  String get explore => 'လေ့လာကြည့်မယ်';

  @override
  String get home => 'ပင်မ';

  @override
  String get settings => 'ဆက်တင်များ';

  @override
  String get languageTitle => 'ဘာသာစကား';

  @override
  String get systemLanguage => 'ဖုန်း၏ ဘာသာစကား';

  @override
  String get languageUpdateFailed =>
      'ဘာသာစကား သိမ်းဆည်း၍ မရပါ။ ထပ်စမ်းကြည့်ပါ။';

  @override
  String get logOut => 'အကောင့်မှ ထွက်ရန်';

  @override
  String get productUnavailable => 'ဤပစ္စည်း မရနိုင်ပါ။';

  @override
  String memberTier(String tier) {
    return '$tier အဖွဲ့ဝင်';
  }

  @override
  String pointsToTier(String points, String tier) {
    return '$tier ဖြစ်ဖို့ $points မှတ် လိုပါသေးတယ်';
  }

  @override
  String get notifications => 'အသိပေးချက်များ';

  @override
  String get rewards => 'ဆုများ';

  @override
  String get menu => 'မီနူး';

  @override
  String get wallet => 'ပိုက်ဆံအိတ်';

  @override
  String get offlineMessage =>
      'အင်တာနက်မရှိပါ။ သိမ်းထားသော အချက်အလက်ကို ပြသနေပါသည်။';

  @override
  String nearbyShops(int count) {
    return 'အနီးအနားမှာ J’Donut ဆိုင် $count ဆိုင် ရှိပါတယ်။';
  }

  @override
  String get exploreNow => 'အခုပဲ ကြည့်ရန်';

  @override
  String get orderOnline => 'အွန်လိုင်းမှ မှာယူရန်';

  @override
  String get seasonalSpecials => 'ရာသီအလိုက် အထူးမီနူး';

  @override
  String get popular => 'လူကြိုက်များသော မီနူး';

  @override
  String get orderAgain => 'ထပ်မှာရန်';

  @override
  String get newLabel => 'အသစ်';

  @override
  String discountLabel(int percent) {
    return '$percent% လျှော့ဈေး';
  }

  @override
  String priceMmk(String price) {
    return '$price ကျပ်';
  }

  @override
  String get whatsThis => 'ဘာလဲ။';

  @override
  String get addToCart => 'ခြင်းထဲ ထည့်ရန်';

  @override
  String get addedToCart => 'ခြင်းထဲ ထည့်ပြီးပါပြီ';

  @override
  String get cartTitle => 'ဈေးခြင်း';

  @override
  String get viewCart => 'ဈေးခြင်း ကြည့်ရန်';

  @override
  String get cartEmpty => 'ဈေးခြင်းထဲတွင် ပစ္စည်းမရှိသေးပါ။';

  @override
  String get cartTotal => 'စုစုပေါင်း';

  @override
  String get cartUpdateFailed => 'ဈေးခြင်းကို ပြင်ဆင်၍ မရပါ။ ထပ်စမ်းကြည့်ပါ။';

  @override
  String get removeFromCart => 'ခြင်းထဲမှ ဖယ်ရန်';

  @override
  String get decreaseQuantity => 'အရေအတွက် လျှော့ရန်';

  @override
  String get increaseQuantity => 'အရေအတွက် တိုးရန်';

  @override
  String get dataError => 'ဤအပိုင်းကို ဖွင့်၍ မရပါ။';

  @override
  String get emptySection => 'ဤနေရာတွင် ပြစရာ မရှိသေးပါ။';

  @override
  String get retry => 'ထပ်စမ်းရန်';

  @override
  String get rewardsTitle => 'J’Donuts ဆုလာဘ်များ';

  @override
  String get rewardsBadge => 'ဆုများ';

  @override
  String get totalPoints => 'စုစုပေါင်း မှတ်';

  @override
  String get currentTier => 'လက်ရှိ အဆင့်';

  @override
  String get futureTier => 'မကြာမီ ရောက်မည့်အဆင့်';

  @override
  String nextTierRemaining(String points, String tier) {
    return '$tier ဖြစ်ဖို့ $points မှတ် လိုပါသေးတယ်';
  }

  @override
  String get bronze => 'ကြေး';

  @override
  String get silver => 'ငွေ';

  @override
  String get gold => 'ရွှေ';

  @override
  String get platinum => 'ပလက်တီနမ်';

  @override
  String get earnTab => 'စားရင်း အမှတ်စု';

  @override
  String get giftTab => 'လက်ဆောင်';

  @override
  String get noGifts => 'လက်ဆောင်များကို ဤနေရာတွင် ပြသပါမည်။';

  @override
  String get earn => 'ရယူရန်';

  @override
  String rewardPoints(String points) {
    return '$points မှတ်';
  }

  @override
  String challengeProgress(int done, int goal) {
    return '$done/$goal';
  }
}
