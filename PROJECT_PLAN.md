# J’Donuts Flutter Code Test — Project Plan

**လက်ရှိအဆင့် — UI အတည်ပြုပြီး၊ ကျန်တဲ့ QA စစ်ဆေးချက်များ**

Font review ရဲ့ local preview မှာ Menco family ကို UI စာသားအားလုံးမှာ သုံးထားပါတယ်။ Headings က Bold၊ labels၊ body နဲ့ footer က Medium၊ descriptions က Light၊ primary buttons နဲ့ အလေးပေးစာသားက Black ပါ။ Menco အတွက် app embedding နဲ့ public repo ဖြန့်ဝေခွင့်ကို သီးခြား အတည်ပြုရန် ကျန်ပါတယ်။

Test လက်ခံရရှိချိန်ကနေ **၂ ရက်အတွင်း** Android emulator နဲ့ iOS Simulator နှစ်ခုလုံးမှာ အလုပ်လုပ်တဲ့ Flutter app နဲ့ submission files ကို ပြင်ဆင်မယ်။ ဒီ checklist က Madivizion code test PDF ကို အခြေခံထားပါတယ်။ အောက်က page references တွေကို မူရင်း PDF မှာ ပြန်တိုက်စစ်နိုင်ပါတယ်။

## Checklist အသုံးပြုပုံ

- `[ ]` = မပြီးသေး / စစ်ရန်ကျန်။ `[x]` = ပြီးပြီး သက်ဆိုင်ရာ စစ်ဆေးချက်ကို အတည်ပြုပြီး။
- Task တစ်ခုပြီးရင် လိုအပ်သလို commit၊ စမ်းထားတဲ့ device၊ test ရလဒ် သို့မဟုတ် artifact link ကို task အောက်မှာ မှတ်ပါ။
- **100% complete** ဆိုတာ required checkbox အားလုံး ပြီးပြီး submission items လေးခု အဆင်သင့်ဖြစ်တာကို ဆိုလိုပါတယ်။ Bonus တွေကို သီးခြားမှတ်ပါ။
- Client ပိုင် PDF နဲ့ design screenshots ကို private reference အဖြစ်ထားပါ။ Public repo နဲ့ repo history ထဲ မပါစေရပါ။

## UI အတည်ပြုပြီးနောက် QA checklist

1. [ ] Onboarding စဖွင့်ချိန်နဲ့ Rewards ဝင်ချိန်က frame spikes ကို ရှာပြီး လိုသလို ပြင်ပါ။ Redmi K30 ပေါ်မှာ profile mode နဲ့ ပြန်တိုင်းပြီး အောက်မှာ မှတ်ထားတဲ့ 16.67 ms baseline နဲ့ ယှဉ်ပါ။
2. [x] Seasonal Specials၊ Popular နဲ့ Order Again ကို သီးခြား load လုပ်ပါတယ်။ Popular တစ်ခု fail ဖြစ်တဲ့အခါ ကျန်တဲ့ section တွေ ဆက်ပေါ်တာ၊ Retry က Popular ကိုပဲ load လုပ်တာနဲ့ pull-to-refresh က section အားလုံးကို ပြန်ဖတ်တာကို widget test မှာ စစ်ထားပါတယ်။
3. [ ] Required tasks ပြီးပြီး deadline မတိုင်ခင် အချိန်ကျန်မှ Persistent cart bonus ကို စဉ်းစားပါ။
4. [x] နောက်ဆုံး performance pass ပြီးနောက် source commit `c0bb547` ကနေ Android release APK၊ iOS Simulator ZIP နဲ့ ၃ မိနစ် ၂၄ စက္ကန့် online/offline walkthrough ကို ပြန်ထုတ်ပြီး စစ်ထားပါတယ်။

## Day 1 — Platform setup၊ architecture နဲ့ အဓိက flow

### 1. Project setup နဲ့ platform build

**PDF စည်းကမ်း (pp. 1–2, 12–15)** — Latest stable Flutter/Dart၊ Android emulator နဲ့ iOS Simulator support၊ public Git repo နဲ့ ရှင်းလင်းတဲ့ commit အသေးတွေ လိုပါတယ်။ Design screenshots ကို publish မလုပ်ရပါ။

- [x] PDF requirements၊ နှစ်ရက်စာ plan နဲ့ acceptance checklist ကို ဒီဖိုင်ထဲ မှတ်တမ်းတင်ပါ။
- [x] Public GitHub repo ကို `origin` ချိတ်ပြီး `main` ကို push လုပ်ထားပါတယ်။
- [x] `flutter doctor -v`၊ `flutter --version` နဲ့ Android SDK၊ Xcode၊ simulator runtime စစ်ပါ။ သုံးထားတဲ့ versions ကို မှတ်ပါ။
  - Official SDK archive နဲ့ ပြန်စစ်ထားတဲ့ Flutter 3.47.9 / Dart 3.13.7 ကို project အတွက် သီးသန့် SDK အဖြစ် သုံးပါတယ်။ Android SDK 37.0.0 နဲ့ Xcode 27.2 စစ်ပြီးပါပြီ။ iOS minimum deployment target က 15.0 ပါ။
- [x] Flutter project နဲ့ Git ignore rules ပြင်ပါ။ PDF၊ design screenshots၊ build outputs နဲ့ local secrets တွေ staging/history ထဲ မပါကြောင်း စစ်ပါ။ လုပ်ဆောင်ချက်အလိုက် commit အသေးတွေ ခွဲပါ။
- [x] Starter app ကို Android emulator နဲ့ iOS Simulator နှစ်ခုလုံးမှာ launch စမ်းပါ။ Android release APK နဲ့ iOS Simulator app build လုပ်ပုံကို Day 1 မှာ စမ်းထားပါ။
  - Android release APK ကို Flutter 3.44.5 နဲ့ build ပြီး Pixel 10 Pro emulator မှာ install/launch အောင်မြင်ပါတယ်။ Final APK ကို Flutter 3.47.9 နဲ့ ပြန် build/install စစ်ပါမယ်။
  - Flutter 3.47.9 နဲ့ `flutter build ios --simulator --debug` အောင်မြင်ပါတယ်။ Bundle မှာ arm64 နဲ့ x86_64 ပါပါတယ်။ Zip ဖြည်ပြီး iPhone 17 Pro Simulator မှာ install/launch စစ်ပြီးပါပြီ။
  - Flutter 3.47.9 နဲ့ analyzer clean ဖြစ်ပြီး starter smoke test pass ပါတယ်။
- [x] Donut၊ coffee၊ banner၊ shop နဲ့ profile ပုံတွေကို app ထဲ bundle လုပ်ပြီး public repo မှာ သုံးခွင့်ရှိကြောင်း စစ်ပါ။

### 2. Architecture၊ database နဲ့ offline behavior

**PDF စည်းကမ်း (pp. 6–7, 13–15)** — Local database က UI ရဲ့ source of truth ဖြစ်ရမယ်။ JSON ကနေ seed လုပ်ရမယ်။ ပထမဆုံး launch မှာပါ offline ပုံတွေ ရရမယ်။ Mock server သုံးမယ်ဆိုရင် အပို network စည်းကမ်းတွေရှိပါတယ်။

**ရွေးချယ်ထားတာ** — Riverpod ကို state နဲ့ DI နှစ်ခုလုံးအတွက်၊ Drift/SQLite ကို database အတွက်၊ `go_router` ကို navigation အတွက် သုံးမယ်။ Member tier ကို Rewards reference အတိုင်း **Silver၊ Gold ရောက်ဖို့ 500 points** လို့ seed လုပ်ပြီး Home နဲ့ Rewards နှစ်ခုလုံးမှာ တူညီအောင် ပြမယ်။ အခြေခံ scope မှာ mock server မထည့်ဘဲ refresh က database ကို ပြန်ဖတ်မယ်။

- [x] `auth`, `home`, `product`, `rewards` feature တစ်ခုစီကို `presentation`, `domain`, `data` ခွဲပါ။ Domain မှာ Flutter imports မသုံးပါ။ Data layer က domain repository interfaces ကို implement လုပ်ပါ။
  - Home၊ Product၊ Rewards အတွက် pure Dart interfaces နဲ့ local implementations ရှိပါတယ်။ Auth မှာ domain/data/presentation ခွဲပြီး route ချိတ်ထားပါတယ်။ Home၊ Product နဲ့ Rewards UI ချိတ်ပြီးပါပြီ။
- [x] Riverpod providers ကနေ dependencies ထည့်ပါ။ Widgets ထဲမှာ services မဆောက်ပါ။ Auth redirect guard နဲ့ `/product/:id` route ထည့်ပါ။
  - Riverpod က database နဲ့ repository instances ပေးပါတယ်။ Router နဲ့ auth guard ကို auth flow နဲ့ ချိတ်ပြီး protected Product Detail route ကိုပါ ထည့်ထားပါတယ်။
- [x] Immutable models အတွက် Freezed + `json_serializable` သို့မဟုတ် PDF မှာ လက်ခံထားတဲ့ Dart 3 sealed classes/records ကို သုံးပါ။ Typed `Result` failures သုံးပြီး error တွေကို UI သို့ ပြန်ပို့ပါ။
  - Catalog repositories မှာ Dart records နဲ့ sealed `Result` သုံးထားပါတယ်။ Home၊ Product Detail နဲ့ Rewards မှာ error/empty/loading states ချိတ်ထားပါတယ်။
- [x] Products၊ banners၊ sections၊ shops၊ member နဲ့ challenges ကို bundled JSON ကနေ ပထမ launch မှာ versioned Drift database ထဲ seed လုပ်ပါ။ Seed ထပ်မပွားခြင်းနဲ့ schema migrations ကို စစ်ပါ။ UI က repository မှတစ်ဆင့် database ကို ဖတ်ပါ။
  - Bundled JSON ကို database ပထမဖွင့်ချိန် တစ်ကြိမ်ပဲ seed လုပ်ပါတယ်။ Schema v3 migration က tier progress field ထည့်ပြီး ရှိပြီးသား member data ကို ထိန်းထားတာ စစ်ပြီးပါပြီ။ Database ဖိုင်ကို ပိတ်ဖွင့်ပြီး seed မပွားတာ၊ Product Detail က Home နဲ့တူတဲ့ product ကို ဖတ်တာ၊ Home နဲ့ Rewards က member တစ်ခုတည်း ဖတ်တာကို automated tests နဲ့ စစ်ပြီးပါပြီ။
- [x] Seed images ကို assets အဖြစ် ထည့်ပါ။ Network images အတွက် `cached_network_image` သို့မဟုတ် equivalent disk cache၊ placeholder နဲ့ error state ထည့်ပါ။
- [x] `connectivity_plus` နဲ့ actual reachability check ပေါင်းသုံးပါ။ Offline banner၊ network ပြန်ရင် background refresh နဲ့ pull-to-refresh ထည့်ပါ။ Refresh မအောင်မြင်ရင် နောက်ဆုံးရထားတဲ့ local data ကို ဆက်ပြပါ။
- [x] Network ပိတ်ထားတဲ့ fresh install မှာ seed လုပ်နိုင်ကြောင်း၊ ပုံတွေမြင်ရကြောင်းနဲ့ app ပြန်ဖွင့်ရင် duplicate records မဖြစ်ကြောင်း စမ်းပါ။ Home နဲ့ Rewards ကို member record တစ်ခုတည်းက ကျွေးကြောင်း စစ်ပါ။

### 3. Onboarding၊ fake auth နဲ့ validation

**PDF စည်းကမ်း (pp. 2–5, 12–14)** — Fake auth ဖြစ်ပေမယ့် validation၊ session၊ input ပြန်ထိန်းပေးခြင်းနဲ့ form loading အားလုံး အလုပ်လုပ်ရမယ်။

- [x] Onboarding မှာ Let’s get started နဲ့ Log in entry points ထည့်ပါ။ Google၊ Apple၊ Facebook၊ Terms of Use နဲ့ Privacy Policy အတွက် placeholder sheet သို့မဟုတ် snackbar ပြပါ။
- [x] `AuthRepository` interface နောက်မှာ ~၁ စက္ကန့် ကြာတဲ့ fake implementation ထားပြီး registered users ကို local store ထဲ သိမ်းပါ။ Session ကို `flutter_secure_storage` နဲ့ သိမ်းပါ။
- [x] Register flow ကို Phone → OTP → Name → Date of birth → Welcome → Home အတိုင်း၊ Login flow ကို Phone → OTP → Home အတိုင်း ချိတ်ပါ။ မမှတ်ပုံတင်ရသေးတဲ့ ဖုန်းနံပါတ်အတွက် inline error နဲ့ Register link ပြပါ။
- [x] Back နှိပ်ရင် အရင် input တွေ ကျန်ပါစေ။ Continue က fake call လုပ်နေချိန် loading ပြပြီး double tap တစ်ခါမှာ request တစ်ခုသာ သွားပါစေ။
- [x] **Phone** — `+95` နောက်က spaces၊ dashes နဲ့ leading zero တစ်လုံး ဖယ်ပါ။ ကျန်တာက `9` နဲ့စပြီး နောက်ထပ် ဂဏန်း ၇–၉ လုံး ဖြစ်ရမယ်။ `09254135592` → `+959254135592` ကို စစ်ပါ။ Invalid input မှာ Continue ပိတ်ပြီး focus ဆုံးရှုံးချိန် inline error ပြပါ။
- [x] **OTP** — Numeric keyboard နဲ့ SMS autofill hint ထည့်ပါ။ Digit တစ်လုံးစီ auto-advance၊ backspace နဲ့ နောက်ပြန်ရွှေ့ခြင်း၊ ၆ လုံး paste တို့ အလုပ်လုပ်ပါစေ။ `123456` ကိုပဲ လက်ခံပါ။ Wrong code မှာ boxes လှုပ်၊ code ရှင်း၊ error ပြပါ။
- [x] **OTP lock / Resend** — သုံးခါမှားရင် Resend နှိပ်သည်အထိ entry ပိတ်ပါ။ Timer က 5:00 မှ 0:00 အထိ ဆင်းပြီး 0:00 မှာ Resend ဖွင့်ပါ။ Resend နှိပ်ရင် lock ဖြေပြီး timer ပြန်စပါ။
- [x] **Name** — Trim လုပ်ပြီး first name ၁–၅၀ characters၊ last name optional ဖြစ်ရမယ်။ ဖြည့်ထားရင် တူညီတဲ့ စည်းကမ်းသုံးပါ။ မြန်မာစာအပါအဝင် letters နဲ့ spaces လက်ခံပြီး ဂဏန်းပါရင် inline error ပြပါ။
- [x] **မွေးသက္ကရာဇ်** — Month/day/year သုံးပြီး တကယ်ရှိတဲ့ ရက်စွဲ၊ leap day၊ အနာဂတ်ရက်နဲ့ အသက် ၁၃ နှစ်ပြည့်မပြည့် စစ်ပါ။ Minimum age ကို named constant ထားပါ။ Invalid ရင် inline error နဲ့ disabled Continue ပြပါ။
- [x] Logged-in relaunch → Home၊ logged-out relaunch → Onboarding စမ်းပါ။ Settings မှာ Log out row ထည့်ပါ။
- [x] Domain pure validators နဲ့ use cases အတွက် unit tests၊ Login/Register validation အတွက် widget tests ရေးပါ။ Test names ကို စမ်းတဲ့ behavior အတိုင်း ပေးပါ။

**Milestone evidence** — Phone/OTP form၊ Name၊ DOB နဲ့ Welcome ကို app routes နဲ့ ချိတ်ထားပါတယ်။ iPhone 17 Pro Simulator မှာ real SQLite/secure storage နဲ့ Register → Home → Log out → Log in → Home integration test pass ပါတယ်။ Numeric keyboard configuration၊ OTP autofill hint၊ digit update၊ backspace နဲ့ ၆ လုံး paste ကို widget test မှာ စစ်ထားပါတယ်။ Fake OTP ဖြစ်တဲ့အတွက် SMS ပို့တဲ့ service မပါပါ။ Home catalog နဲ့ Product Detail ကို local database နဲ့ ချိတ်ပြီးပါပြီ။

### 4. Welcome၊ Home၊ Product Detail နဲ့ Rewards data

**PDF စည်းကမ်း (pp. 2, 6–11, 14)** — Home နဲ့ Reward tabs အလုပ်လုပ်ရမယ်။ ကျန် icon သုံးခု placeholder ဖြစ်လို့ရပြီး Settings မှာ Log out ပါရမယ်။ Screen တစ်ခုစီမှာ သက်ဆိုင်ရာ loading/error/empty states ပါရမယ်။

- [x] Welcome မှာ donut tiles နဲ့ Let’s explore ကို ပြပြီး Home သို့ ချိတ်ပါ။
- [x] Home header မှာ member name၊ photo၊ tier၊ next-tier points နဲ့ notification count ပြပါ။ Banner carousel နဲ့ Seasonal specials၊ Popular၊ Order again horizontal lists ထည့်ပြီး discount badges ကို data ကနေ ဖတ်ပါ။
- [x] Nearby shop cards နဲ့ shop count ပြပါ။ Explore now နဲ့ Order online အတွက် display ပဲ လိုပါတယ်။ Home loading မှာ skeleton သုံးပြီး section တစ်ခုချင်းစီမှာ empty/error states ထည့်ပါ။
- [x] Product tile တိုင်းက သက်ဆိုင်ရာ detail ကို ဖွင့်ပါစေ။ Coconut Donut reference အတိုင်း code၊ name၊ image၊ `3,200 MMK` ပုံစံ၊ data အရ New badge နဲ့ What’s this? description ပြပါ။
- [x] Quantity ကို ၁ အောက် မဆင်းစေပါ။ Add to cart မှာ quantity × price တန်ဖိုး ချက်ချင်းပြောင်းပြီး tap feedback ပြပါ။
- [x] Rewards မှာ local member record၊ tier ladder၊ points ring၊ Eat more earn more/Gift tabs နဲ့ challenges ပြပါ။ Rewards badge၊ Gift နဲ့ Earn အတွက် လိုအပ်တဲ့ visual feedback ထည့်ပါ။
- [x] Register → Home → Product Detail integration test ရေးပြီး run ပါ။ Android emulator မှာ airplane mode ဖွင့်ပြီး Wi-Fi ပိတ်ထားချိန် offline banner၊ Coconut Donut ပုံ၊ 3,200 MMK ဈေးနဲ့ 6,400 MMK live total ကို စစ်ပြီး pass ပါတယ်။
  - iPhone 17 Pro Simulator မှာလည်း တူညီတဲ့ Register → Home → Product Detail → Log out → Log in test pass ပါတယ်။
- [x] Home၊ Product Detail နဲ့ Rewards ကို ပုံတွေအပါအဝင် airplane mode နဲ့ အစအဆုံး ထပ်စမ်းပါ။ Fresh Android emulator မှာ Wi-Fi ပိတ်ထားပြီး Register → Home → Product Detail → Rewards → Log out → Log in pass ပါတယ်။ iPhone 17 Pro Simulator မှာလည်း full flow pass ပါတယ်။

**Home / Product update** — Donut cutouts နဲ့ ကျန် catalog artwork ကို local assets အဖြစ် bundle လုပ်ထားပါတယ်။ Home၊ Product Detail နဲ့ Rewards ကို iPhone 17 Pro Simulator မှာ PDF နဲ့ တိုက်စစ်ပြီး banner၊ card၊ product ပုံအချိုး၊ tabs နဲ့ navigation ကို ညှိထားပါတယ်။

- [x] Stock preview ပုံတွေကို ကိုယ်ပိုင် AI-generated donut cutouts နဲ့ အစားထိုးပါ။ Coffee၊ bakery၊ assortment နဲ့ fictional member portrait ကိုလည်း offline အတွက် bundle ထည့်ပါ။

## Day 2 — UI polish၊ motion၊ verification နဲ့ submission

### 5. Design fidelity နဲ့ required motion

**PDF စည်းကမ်း (pp. 1–2, 5, 8–14)** — Design states ၁၀ ခုနဲ့ နီးစပ်ရမယ်။ Name empty နဲ့ filled က route တစ်ခုရဲ့ states နှစ်ခုဖြစ်ပါတယ်။ Portrait 4.7–6.9 လက်မ၊ text scale 1.3 အထိ support ရမယ်။ Motion စာရင်းက အနည်းဆုံး လိုအပ်ချက်ပါ။

**Visual review** — Onboarding၊ Phone၊ OTP၊ Name (empty/filled)၊ DOB နဲ့ Welcome ကို PDF reference နဲ့ တိုက်စစ်ပြီး rounded heading font၊ artwork အရွယ်နဲ့ fade၊ field/button spacing၊ back tile နဲ့ progress checkmark ကို ညှိထားပါတယ်။ 320 × 568 viewport၊ text scale 1.3 နဲ့ keyboard inset ကို auth widget test ထဲမှာ စစ်ထားပါတယ်။ Donut artwork အတွက် watermark မပါတဲ့ ကိုယ်ပိုင် cutouts တွေကို bundle လုပ်ထားပါတယ်။

- [x] Design states ၁၀ ခုကို reference နဲ့ spacing၊ type၊ colors၊ imagery နဲ့ layout တိုက်စစ်ပါ။ Shared theme tokens သုံးပါ။ UI strings ကို ARB + `gen-l10n` ထဲထားပါ။ Portrait screen အသေး/အကြီး၊ text scale 1.3 နဲ့ keyboard ဖွင့်ထားချိန် overflow စစ်ပါ။
- [x] **Onboarding** — Donut circles drift in လုပ်ပြီး title နဲ့ buttons အချိန်ခြားကာ ဝင်လာပါစေ။
- [x] **Registration** — Shared-axis သို့မဟုတ် slide transitions၊ progress ring 25% → 50% → 75% → 100% → checkmark ထည့်ပါ။ Input focus/error နဲ့ wrong OTP shake ကို animate လုပ်ပါ။
- [x] **Buttons** — Press scale နဲ့ Continue က loading state သို့ ပြောင်းတဲ့ motion ထည့်ပါ။
- [x] **Welcome** — Donut tiles အချိန်ခြားပြီး slide in လုပ်ကာ title fade up ဖြစ်ပါစေ။
- [x] **Home / Product** — Skeleton shimmer၊ sections အချိန်ခြားပြီး ပေါ်လာခြင်း၊ carousel autoplay၊ product image Hero transition နဲ့ quantity number animation ထည့်ပါ။
- [x] **Rewards** — Ring က 0 ကနေ member progress ဆီ sweep လုပ်ပြီး total 680,000 ထိ count-up လုပ်ပါ။ Silver → Gold → Platinum အစဉ်လိုက် ပေါ်ပြီး current tier highlight နဲ့ next-tier line fill ပြပါ။
- [x] **Rewards tabs / challenges** — Moving tab indicator၊ card list transition နဲ့ card entrance အချိန်ခြားပါ။ Donut 1/4 နဲ့ 4/4 ကို အပိုင်းလိုက် အရောင်ဖြည့်ပြီး coffee arc 9/12 ပြပါ။ Ring နဲ့ progress art ကို `CustomPainter` သို့မဟုတ် Rive နဲ့ ဆွဲပါ။
- [x] **Earn / badge / nav** — 4/4 ပြည့်ရင် Earn active နဲ့ attention cue၊ ကျန်ရင် grey state၊ tap feedback ပါစေ။ Rewards (3) badge pop နဲ့ Home ↔ Reward active pill slide ထည့်ပါ။
  - Rewards ကို 320 × 568 viewport၊ text scale 1.3 နဲ့ Reduce Motion ဖွင့်ပြီး widget test စမ်းထားပါတယ်။
- [x] Durations နဲ့ curves ကို motion file တစ်ခုထဲမှာ named constants ထားပါ။ Motion အများစုကို Flutter animation APIs နဲ့ရေးပါ။ `MediaQuery.disableAnimations` နဲ့ Reduce Motion အတွက် animations တိုစေခြင်း သို့မဟုတ် ကျော်ခြင်းကို စမ်းပါ။
- [x] Redmi K30 (Android 11) ဖုန်းအစစ်မှာ Flutter profile build နဲ့ animation frame timing တိုင်းပါ။ Test copy ကို USB ကနေ install လုပ်ပြီး ပုံမှန် screen input နဲ့ စမ်းထားပါတယ်။
- [ ] 60 fps အတွက် frame budget 16.67 ms ကျော်တဲ့ frames တွေကို optimize လုပ်ပြီး ဖုန်းအစစ်ပေါ်မှာ ပြန်တိုင်းပါ။

**Redmi K30 profile result (2026-11-09)** — Flutter frame timings စုစုပေါင်း 1,510 ခုထဲက 60 ခုမှာ build သို့မဟုတ် raster stage က 16.67 ms ကျော်ပါတယ်။ Cold onboarding 13/54၊ Home scroll 3/86၊ Product Detail Hero ဝင်ချိန် 2/6၊ quantity animation 0/214၊ Rewards ပထမအကြိမ် 5/103 နဲ့ ထပ်ဝင်ချိန် 4/93 ကျော်ပါတယ်။ Build p95 8.76 ms နဲ့ raster p95 15.40 ms ဖြစ်ပါတယ်။ First Home entry မှာ samples မရခဲ့လို့ Home scroll နဲ့ tab ကနေ ပြန်ဝင်ချိန်ကို သီးခြားတိုင်းထားပါတယ်။

**Redmi K30 profile audit (2026-11-10)** — Rewards tier ladder နဲ့ points animation ကို သီးခြား update လုပ်အောင် ပြင်ပြီး Android 11၊ display 120 Hz မှာ ပြန်တိုင်းထားပါတယ်။ Frame 1,642 ခုထဲက 46 ခုမှာ build သို့မဟုတ် raster က 16.67 ms ကျော်ပါတယ်။ Build p95 5.59 ms၊ raster p95 14.51 ms ဖြစ်ပါတယ်။ Home ပထမအကြိမ်ဝင်တာနဲ့ Rewards entry/tabs မှာ spikes ကျန်ပါတယ်။ အပေါ်က 60 fps jank-free checklist ကို ဖွင့်ထားပါတယ်။

**Home / Rewards retest (2026-11-10)** — Home product rail တွေကို scroll viewport နားရောက်မှ ဆောက်ပြီး Rewards points ring ကို layout ပြန်လုပ်စရာမလိုဘဲ repaint လုပ်အောင် ပြင်ထားပါတယ်။ Redmi K30 မှာ profile mode၊ display 120 Hz နဲ့ မပြင်ခင်/ပြင်ပြီး ၅ ကြိမ်စီ တိုင်းထားပါတယ်။ Cold Home မှာ 16.67 ms ကျော်တဲ့ frames က 29/428 (6.8%) ကနေ 24/467 (5.1%) ဖြစ်လာပါတယ်။ Rewards entry ရဲ့ peak က 44.70 ms ကနေ 31.20 ms ကျပြီး budget ကျော်တဲ့အချိုးက 3.1% ဝန်းကျင်မှာ ရှိနေပါတယ်။ Analyzer၊ unit/widget tests 15 ခု၊ compact Android airplane-mode flow နဲ့ iOS Simulator flow အောင်ပါတယ်။ 60 fps jank-free checklist ကို ဆက်ဖွင့်ထားပါတယ်။

**Final Redmi K30 profile (2026-11-10)** — Source commit `fde9392` ကို display 120 Hz၊ profile mode နဲ့ Cold Home နှင့် Rewards entry ၅ ကြိမ်စီ ပြန်တိုင်းထားပါတယ်။ 16.67 ms ကျော်တဲ့ frames က Home 25/462 (5.4%) နဲ့ Rewards 24/513 (4.7%) ပါ။ အကြာဆုံး stage က Home 48.44 ms နဲ့ Rewards 28.13 ms ဖြစ်ပါတယ်။ 60 fps jank-free checklist ကို ဆက်ဖွင့်ထားပါတယ်။

**Final Redmi K30 flow check (2026-11-10)** — `fde9392` ရဲ့ online နဲ့ airplane-mode integration flows နှစ်ခုလုံး အောင်ပါတယ်။ Release APK ကို install လုပ်ပြီး airplane mode ထဲမှာ app ပိတ်ဖွင့်တဲ့အခါ saved session နဲ့ local Home catalog ပြန်တက်တာကိုလည်း စစ်ထားပါတယ်။

**Last 60 Hz trace pass (2026-11-10)** — Redmi K30 ရဲ့ active 60 Hz ကို အတည်ပြုပြီး profile timeline ဖမ်းထားပါတယ်။ နှေးတဲ့ raster frames တချို့မှာ glyph atlas ပုံဖော်တဲ့အလုပ် ပါပါတယ်။ Entrance translation ကို device pixel နဲ့ ညှိပြီး Rewards points label ကို အဆင့်လိုက် update လုပ်ထားပါတယ်။ Build တစ်ခုစီ ၅ ကြိမ်တိုင်းရာမှာ 16.67 ms ကျော်တာ Home 45/268 (16.8%) → 31/266 (11.7%)၊ Rewards 46/296 (15.5%) → 33/298 (11.1%) ပါ။ Rewards peak 48.57 ms → 29.98 ms ဖြစ်ပါတယ်။ ပြင်ဆင်ချက်ကို ထားပြီး jank-free 60 fps checklist ကို ဖွင့်ထားပါတယ်။

### 6. နောက်ဆုံး quality gates

**PDF စည်းကမ်း (pp. 13–15)** — `flutter analyze` clean ဖြစ်ရမယ်။ `flutter_lints` သို့မဟုတ် `very_good_analysis`၊ နားလည်လွယ်တဲ့ names နဲ့ named constants သုံးပါ။ Functions ကို အကြမ်းဖျင်း ၂၀ လိုင်း၊ files ကို ၃၀၀ လိုင်းဝန်းကျင်အတွင်း ထိန်းပါ။ README အတိုင်း build မရခြင်း၊ main flow crash ဖြစ်ခြင်း၊ widgets ထဲမှာ app data hard-code လုပ်ခြင်းက တစ်ခုခုရှိရင် ချက်ချင်းကျနိုင်ပါတယ်။

- [x] Fresh checkout မှာ README အတိုင်း dependency setup နဲ့ လိုအပ်တဲ့ code generation လုပ်ပြီး Android/iOS builds ပြန်ထုတ်ပါ။
- [x] `flutter analyze`၊ unit/widget tests နဲ့ Register → Home → Product Detail integration test အားလုံး pass ဖြစ်ကြောင်း မှတ်ပါ။
- [x] Android emulator နဲ့ iOS Simulator မှာ Register၊ Log out၊ Log in၊ relaunch၊ invalid inputs၊ product navigation နဲ့ Rewards tabs စမ်းပါ။ Back၊ double tap၊ OTP lock နဲ့ Resend ကိုပါ စစ်ပါ။
- [x] Offline fresh install၊ အသုံးပြုပြီးမှ airplane mode ဝင်တာ၊ offline relaunch၊ connection ပြန်ရတာနဲ့ pull-to-refresh စစ်ပါ။ UI data က local database ကနေ လာပြီး images မြင်ရကြောင်း အတည်ပြုပါ။
- [x] သတ်မှတ်ထားတဲ့ UI states နဲ့ motion ကို တစ်ပတ်လည် စမ်းပါ။ Public commit history နဲ့ source tree ထဲ client reference PDF/screenshots မပါကြောင်း ပြန်စစ်ပါ။

**Final QA** — Flutter 3.47.9 / Dart 3.13.7 နဲ့ clean checkout မှာ analyzer clean၊ unit/widget tests 15 ခု pass ပါတယ်။ Android emulator မှာ 320 × 568၊ text scale 1.3 နဲ့ airplane mode full integration pass ပါတယ်။ iPhone 17 Pro Simulator မှာ full integration pass ပါတယ်။ Android release APK မှာ offline register လုပ်ပြီး force-stop/relaunch နောက် session နဲ့ saved catalog ပြန်တက်တာ အတည်ပြုထားပါတယ်။ Walkthrough test မှာ network ပြန်ဖွင့်ပြီး offline banner ပျောက်တာနဲ့ Home pull-to-refresh ကို စစ်ထားပါတယ်။ Reduce Motion ကို Rewards widget test နဲ့ shared motion settings မှာ စစ်ထားပါတယ်။

**Post-UI QA (2026-11-10)** — PDF ရဲ့ pp. 3–15 နဲ့ ပြန်တိုက်စစ်ပါတယ်။ အသုံးမပြုတော့တဲ့ Comfortaa/Montserrat font files ကို ဖယ်ထားပြီး လက်ရှိ UI သုံးတဲ့ asset နဲ့ font licenses တွေကို ထိန်းထားပါတယ်။ Shared button နဲ့ feedback ကို feature တွေကနေ ခွဲထားပါတယ်။ Home product label height ကို font metrics နဲ့ တွက်ပြီး iOS Simulator မှာ တွေ့ခဲ့တဲ့ overflow ကို ပြင်ထားပါတယ်။ Clean source copy မှာ README command တွေနဲ့ analyzer၊ tests၊ Android release APK နဲ့ iOS Simulator build ကို ပြန်စစ်ထားပါတယ်။

**Updated delivery evidence (2026-11-10)** — Redmi K30 မှာ online နဲ့ airplane-mode Register → Log out → Log in → Home → Product Detail → Rewards walkthrough အောင်ပြီး ၃ မိနစ် ၃၆ စက္ကန့် recording ရှိပါတယ်။ Release APK မှာ offline registration၊ force-stop/relaunch၊ session restore၊ Rewards points နဲ့ reconnect banner ကို စစ်ပြီးပါပြီ။ iPhone 17 Pro Simulator မှာ zip ကို ဖြည်ပြီး install/launch လုပ်ထားသလို Android emulator 320 × 568၊ text scale 1.3၊ airplane mode နဲ့ integration flow ကိုလည်း ပြန်စစ်ထားပါတယ်။

### 7. Submission items လေးခု

**PDF စည်းကမ်း (pp. 14–15)** — Test ပို့လာတဲ့ email ကို reply လုပ်ပြီး public repo၊ installable builds၊ recording နဲ့ README ပေးရမယ်။ AI coding tools သုံးလို့ရပြီး shortlist ဝင်ရင် ကိုယ်တင်ထားတဲ့ code ကို ရှင်းပြနိုင်ရမယ်။

Day 2 ရဲ့ နောက်ဆုံး **၃ နာရီ** ကို clean build၊ install verification၊ recording နဲ့ submission အတွက် ချန်ထားမယ်။

- [x] **Public repo** — User ပေးတဲ့ GitHub/GitLab repo link ကို အသုံးပြုပြီး final commit နဲ့ readable commit history ရှိကြောင်း စစ်ပါ။ Reviewer က repo ဖွင့်လို့ရကြောင်း အတည်ပြုပါ။
- [x] **Builds** — Android release `.apk` နဲ့ iOS Simulator `.app` zip ပြင်ပါ။ PDF မှာ `flutter build ios --simulator` ကို ဖော်ပြထားပါတယ်။ Simulator build အတွက် debug mode သုံးပြီး အမှန်တကယ် zip ဖြည်ကာ simulator မှာ install/launch စမ်းပါ။ Android APK ကိုလည်း install/launch စမ်းပါ။
- [x] **Recording** — ၂–၄ မိနစ်အတွင်း Register → Log out → Log in → Home → Product Detail → Rewards ပြပါ။ တူညီတဲ့ flow ကို airplane mode မှာ ထပ်ပြပါ။ Online နဲ့ airplane mode အပိုင်းတွေမှာ demo phone number သီးသန့်သုံးထားပြီး final MP4 က ၃ မိနစ် ၃၁ စက္ကန့် ကြာပါတယ်။
- [x] **README** — Run/setup၊ Flutter/Dart versions၊ architecture နဲ့ folder map၊ state management ရွေးရတဲ့အကြောင်း၊ offline strategy၊ animations၊ fake OTP၊ known gaps နဲ့ time spent ထည့်ပါ။ README instructions ကို fresh checkout နဲ့ verify လုပ်ပါ။
- [ ] Email reply အတွက် repo/README links၊ builds နဲ့ video attachments သို့မဟုတ် links ပြင်ပါ။ Link permissions နဲ့ artifact versions ကို စစ်ပါ။ မူရင်း email ကို reply ပို့ပြီးမှ submission ကို sent အဖြစ် မှတ်ပါ။
- [ ] Walkthrough အတွက် auth ကို API နဲ့ ဘယ်လိုအစားထိုးမလဲ၊ database/refresh ဘယ်လိုအလုပ်လုပ်လဲ၊ motion နဲ့ tests ဘာကြောင့် ဒီလိုရေးထားလဲ ရှင်းပြနိုင်အောင် ပြန်ကြည့်ပါ။

## Bonus — Required tasks ပြည့်ပြီး အချိန်ကျန်မှ

- [ ] Persistent cart။
- [ ] Burmese locale။
- [ ] Minimum ထက်ပိုတဲ့ animation။
- [x] GitHub Actions မှာ Flutter 3.47.9 နဲ့ push / pull request တိုင်း analyzer နဲ့ unit/widget tests run အောင် ထည့်ထားပါတယ်။
- [ ] Mock server ထည့်ပါက public data အတွက် `/v1/...`၊ `{data, error, meta}` envelope၊ Dio timeouts၊ retry/logging interceptors၊ source နဲ့ README run instructions ပါစေ။ Server က database ကို update လုပ်ပြီး UI က local database ကိုပဲ ဖတ်ပါစေ။

## PDF အမှတ်ပေးပုံ

| အပိုင်း | အလေးချိန် |
|---|---:|
| Offline data | 20% |
| Motion and presentation | 20% |
| Architecture and code quality | 20% |
| UI fidelity | 15% |
| Validation and flow | 10% |
| Tests | 10% |
| Delivery | 5% |
