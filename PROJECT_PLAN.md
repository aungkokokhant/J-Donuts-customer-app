# J’Donuts Flutter Code Test — Project Plan

**Status: Planning complete · Implementation pending**

Test လက်ခံရရှိချိန်ကနေ **၂ ရက်အတွင်း** Android emulator နဲ့ iOS Simulator နှစ်ခုလုံးမှာ အလုပ်လုပ်တဲ့ Flutter app နဲ့ submission files ကို ပြင်ဆင်မယ်။ ဒီ checklist က Madivizion code test PDF ကို အခြေခံထားပါတယ်။ အောက်က page references တွေကို မူရင်း PDF မှာ ပြန်တိုက်စစ်နိုင်ပါတယ်။

## Checklist အသုံးပြုပုံ

- `[ ]` = မပြီးသေး / စစ်ရန်ကျန်။ `[x]` = ပြီးပြီး သက်ဆိုင်ရာ စစ်ဆေးချက်ကို အတည်ပြုပြီး။
- Task တစ်ခုပြီးရင် လိုအပ်သလို commit၊ စမ်းထားတဲ့ device၊ test ရလဒ် သို့မဟုတ် artifact link ကို task အောက်မှာ မှတ်ပါ။
- **100% complete** ဆိုတာ required checkbox အားလုံး ပြီးပြီး submission items လေးခု အဆင်သင့်ဖြစ်တာကို ဆိုလိုပါတယ်။ Bonus တွေကို သီးခြားမှတ်ပါ။
- Client ပိုင် PDF နဲ့ design screenshots ကို private reference အဖြစ်ထားပါ။ Public repo နဲ့ repo history ထဲ မပါစေရပါ။

## Day 1 — Platform setup၊ architecture နဲ့ အဓိက flow

### 1. Project setup နဲ့ platform build

**PDF စည်းကမ်း (pp. 1–2, 12–15)** — Latest stable Flutter/Dart၊ Android emulator နဲ့ iOS Simulator support၊ public Git repo နဲ့ ရှင်းလင်းတဲ့ commit အသေးတွေ လိုပါတယ်။ Design screenshots ကို publish မလုပ်ရပါ။

- [x] PDF requirements၊ နှစ်ရက်စာ plan နဲ့ acceptance checklist ကို ဒီဖိုင်ထဲ မှတ်တမ်းတင်ပါ။
- [x] Project remote ကို HTTPS နဲ့ စစ်ပြီး `origin` ချိတ်ထားပါပြီ။ `https://github.com/aungkokokhant/J-Donuts-customer-app.git` မှာ စစ်ဆေးချိန် Git refs မရှိသေးပါ။
- [x] `flutter doctor -v`၊ `flutter --version` နဲ့ Android SDK၊ Xcode၊ simulator runtime စစ်ပါ။ သုံးထားတဲ့ versions ကို မှတ်ပါ။
  - Official stable release Flutter 3.47.9 / Dart 3.13.7 ကို project အတွက် သီးသန့် SDK အဖြစ် သုံးပါတယ်။ Android SDK 37.0.0 နဲ့ Xcode 27.2 စစ်ပြီးပါပြီ။ iOS minimum deployment target က 15.0 ပါ။
- [x] Flutter project နဲ့ Git ignore rules ပြင်ပါ။ PDF၊ design screenshots၊ build outputs နဲ့ local secrets တွေ staging/history ထဲ မပါကြောင်း စစ်ပါ။ လုပ်ဆောင်ချက်အလိုက် commit အသေးတွေ ခွဲပါ။
- [x] Starter app ကို Android emulator နဲ့ iOS Simulator နှစ်ခုလုံးမှာ launch စမ်းပါ။ Android release APK နဲ့ iOS Simulator app build လုပ်ပုံကို Day 1 မှာ စမ်းထားပါ။
  - Android release APK ကို Flutter 3.44.5 နဲ့ build ပြီး Pixel 10 Pro emulator မှာ install/launch အောင်မြင်ပါတယ်။ Final APK ကို Flutter 3.47.9 နဲ့ ပြန် build/install စစ်ပါမယ်။
  - Flutter 3.47.9 နဲ့ `flutter build ios --simulator --debug` အောင်မြင်ပါတယ်။ Bundle မှာ arm64 နဲ့ x86_64 ပါပါတယ်။ Zip ဖြည်ပြီး iPhone 17 Pro Simulator မှာ install/launch စစ်ပြီးပါပြီ။
  - Flutter 3.47.9 နဲ့ analyzer clean ဖြစ်ပြီး starter smoke test pass ပါတယ်။
- [ ] Donut၊ coffee၊ banner၊ shop နဲ့ profile ပုံတွေကို app ထဲ bundle လုပ်ပြီး public repo မှာ သုံးခွင့်ရှိကြောင်း စစ်ပါ။

### 2. Architecture၊ database နဲ့ offline behavior

**PDF စည်းကမ်း (pp. 6–7, 13–15)** — Local database က UI ရဲ့ source of truth ဖြစ်ရမယ်။ JSON ကနေ seed လုပ်ရမယ်။ ပထမဆုံး launch မှာပါ offline ပုံတွေ ရရမယ်။ Mock server သုံးမယ်ဆိုရင် အပို network စည်းကမ်းတွေရှိပါတယ်။

**ရွေးချယ်ထားတာ** — Riverpod ကို state နဲ့ DI နှစ်ခုလုံးအတွက်၊ Drift/SQLite ကို database အတွက်၊ `go_router` ကို navigation အတွက် သုံးမယ်။ Member tier ကို Rewards reference အတိုင်း **Silver၊ Gold ရောက်ဖို့ 500 points** လို့ seed လုပ်ပြီး Home နဲ့ Rewards နှစ်ခုလုံးမှာ တူညီအောင် ပြမယ်။ အခြေခံ scope မှာ mock server မထည့်ဘဲ refresh က database ကို ပြန်ဖတ်မယ်။

- [ ] `auth`, `home`, `product`, `rewards` feature တစ်ခုစီကို `presentation`, `domain`, `data` ခွဲပါ။ Domain မှာ Flutter imports မသုံးပါ။ Data layer က domain repository interfaces ကို implement လုပ်ပါ။
  - ပြီးပြီးသား: Home၊ Product၊ Rewards အတွက် pure Dart interfaces နဲ့ local implementations ရှိပါတယ်။ Auth နဲ့ screen တွေ ချိတ်ရန် ကျန်ပါတယ်။
- [ ] Riverpod providers ကနေ dependencies ထည့်ပါ။ Widgets ထဲမှာ services မဆောက်ပါ။ Auth redirect guard နဲ့ `/product/:id` route ထည့်ပါ။
  - ပြီးပြီးသား: Riverpod က database နဲ့ repository instances ပေးပါတယ်။ Router နဲ့ auth guard ကို auth flow နဲ့အတူ ချိတ်ပါမယ်။
- [ ] Immutable models အတွက် Freezed + `json_serializable` သို့မဟုတ် PDF မှာ လက်ခံထားတဲ့ Dart 3 sealed classes/records ကို သုံးပါ။ Typed `Result` failures သုံးပြီး error တွေကို UI သို့ ပြန်ပို့ပါ။
  - ပြီးပြီးသား: Catalog repositories မှာ Dart records နဲ့ sealed `Result` သုံးထားပါတယ်။ Screen error states ချိတ်ရန် ကျန်ပါတယ်။
- [ ] Products၊ banners၊ sections၊ shops၊ member နဲ့ challenges ကို bundled JSON ကနေ ပထမ launch မှာ versioned Drift database ထဲ seed လုပ်ပါ။ Seed ထပ်မပွားခြင်းနဲ့ schema migrations ကို စစ်ပါ။ UI က repository မှတစ်ဆင့် database ကို ဖတ်ပါ။
  - ပြီးပြီးသား: Schema v1 က bundled JSON ကို database ပထမဖွင့်ချိန် တစ်ကြိမ်ပဲ seed လုပ်ပါတယ်။ Database ဖိုင်ကို ပိတ်ဖွင့်ပြီး seed မပွားတာ၊ Product Detail က Home နဲ့တူတဲ့ product ကို ဖတ်တာ၊ Home နဲ့ Rewards က member တစ်ခုတည်း ဖတ်တာကို automated tests နဲ့ စစ်ပြီးပါပြီ။
- [ ] Seed images ကို assets အဖြစ် ထည့်ပါ။ Network images အတွက် `cached_network_image` သို့မဟုတ် equivalent disk cache၊ placeholder နဲ့ error state ထည့်ပါ။
- [ ] `connectivity_plus` နဲ့ actual reachability check ပေါင်းသုံးပါ။ Offline banner၊ network ပြန်ရင် background refresh နဲ့ pull-to-refresh ထည့်ပါ။ Refresh မအောင်မြင်ရင် နောက်ဆုံးရထားတဲ့ local data ကို ဆက်ပြပါ။
- [ ] Network ပိတ်ထားတဲ့ fresh install မှာ seed လုပ်နိုင်ကြောင်း၊ ပုံတွေမြင်ရကြောင်းနဲ့ app ပြန်ဖွင့်ရင် duplicate records မဖြစ်ကြောင်း စမ်းပါ။ Home နဲ့ Rewards ကို member record တစ်ခုတည်းက ကျွေးကြောင်း စစ်ပါ။

### 3. Onboarding၊ fake auth နဲ့ validation

**PDF စည်းကမ်း (pp. 2–5, 12–14)** — Fake auth ဖြစ်ပေမယ့် validation၊ session၊ input ပြန်ထိန်းပေးခြင်းနဲ့ form loading အားလုံး အလုပ်လုပ်ရမယ်။

- [ ] Onboarding မှာ Let’s get started နဲ့ Log in entry points ထည့်ပါ။ Google၊ Apple၊ Facebook၊ Terms of Use နဲ့ Privacy Policy အတွက် placeholder sheet သို့မဟုတ် snackbar ပြပါ။
- [ ] `AuthRepository` interface နောက်မှာ ~၁ စက္ကန့် ကြာတဲ့ fake implementation ထားပြီး registered users ကို local store ထဲ သိမ်းပါ။ Session ကို `flutter_secure_storage` နဲ့ သိမ်းပါ။
- [ ] Register flow ကို Phone → OTP → Name → Date of birth → Welcome → Home အတိုင်း၊ Login flow ကို Phone → OTP → Home အတိုင်း ချိတ်ပါ။ မမှတ်ပုံတင်ရသေးတဲ့ ဖုန်းနံပါတ်အတွက် inline error နဲ့ Register link ပြပါ။
- [ ] Back နှိပ်ရင် အရင် input တွေ ကျန်ပါစေ။ Continue က fake call လုပ်နေချိန် loading ပြပြီး double tap တစ်ခါမှာ request တစ်ခုသာ သွားပါစေ။
- [ ] **Phone** — `+95` နောက်က spaces၊ dashes နဲ့ leading zero တစ်လုံး ဖယ်ပါ။ ကျန်တာက `9` နဲ့စပြီး နောက်ထပ် ဂဏန်း ၇–၉ လုံး ဖြစ်ရမယ်။ `09254135592` → `+959254135592` ကို စစ်ပါ။ Invalid input မှာ Continue ပိတ်ပြီး focus ဆုံးရှုံးချိန် inline error ပြပါ။
- [ ] **OTP** — Numeric keyboard နဲ့ SMS autofill hint ထည့်ပါ။ Digit တစ်လုံးစီ auto-advance၊ backspace နဲ့ နောက်ပြန်ရွှေ့ခြင်း၊ ၆ လုံး paste တို့ အလုပ်လုပ်ပါစေ။ `123456` ကိုပဲ လက်ခံပါ။ Wrong code မှာ boxes လှုပ်၊ code ရှင်း၊ error ပြပါ။
- [ ] **OTP lock / Resend** — သုံးခါမှားရင် Resend နှိပ်သည်အထိ entry ပိတ်ပါ။ Timer က 5:00 မှ 0:00 အထိ ဆင်းပြီး 0:00 မှာ Resend ဖွင့်ပါ။ Resend နှိပ်ရင် lock ဖြေပြီး timer ပြန်စပါ။
- [ ] **Name** — Trim လုပ်ပြီး first name ၁–၅၀ characters၊ last name optional ဖြစ်ရမယ်။ ဖြည့်ထားရင် တူညီတဲ့ စည်းကမ်းသုံးပါ။ မြန်မာစာအပါအဝင် letters နဲ့ spaces လက်ခံပြီး ဂဏန်းပါရင် inline error ပြပါ။
- [ ] **မွေးသက္ကရာဇ်** — Month/day/year သုံးပြီး တကယ်ရှိတဲ့ ရက်စွဲ၊ leap day၊ အနာဂတ်ရက်နဲ့ အသက် ၁၃ နှစ်ပြည့်မပြည့် စစ်ပါ။ Minimum age ကို named constant ထားပါ။ Invalid ရင် inline error နဲ့ disabled Continue ပြပါ။
- [ ] Logged-in relaunch → Home၊ logged-out relaunch → Onboarding စမ်းပါ။ Settings မှာ Log out row ထည့်ပါ။
- [ ] Domain pure validators နဲ့ use cases အတွက် unit tests၊ Login/Register validation အတွက် widget tests ရေးပါ။ Test names ကို စမ်းတဲ့ behavior အတိုင်း ပေးပါ။

### 4. Welcome၊ Home၊ Product Detail နဲ့ Rewards data

**PDF စည်းကမ်း (pp. 2, 6–11, 14)** — Home နဲ့ Reward tabs အလုပ်လုပ်ရမယ်။ ကျန် icon သုံးခု placeholder ဖြစ်လို့ရပြီး Settings မှာ Log out ပါရမယ်။ Screen တစ်ခုစီမှာ သက်ဆိုင်ရာ loading/error/empty states ပါရမယ်။

- [ ] Welcome မှာ donut tiles နဲ့ Let’s explore ကို ပြပြီး Home သို့ ချိတ်ပါ။
- [ ] Home header မှာ member name၊ photo၊ tier၊ next-tier points နဲ့ notification count ပြပါ။ Banner carousel နဲ့ Seasonal specials၊ Popular၊ Order again horizontal lists ထည့်ပြီး discount badges ကို data ကနေ ဖတ်ပါ။
- [ ] Nearby shop cards နဲ့ shop count ပြပါ။ Explore now နဲ့ Order online အတွက် display ပဲ လိုပါတယ်။ Home loading မှာ skeleton သုံးပြီး section တစ်ခုချင်းစီမှာ empty/error states ထည့်ပါ။
- [ ] Product tile တိုင်းက သက်ဆိုင်ရာ detail ကို ဖွင့်ပါစေ။ Coconut Donut reference အတိုင်း code၊ name၊ image၊ `3,200 MMK` ပုံစံ၊ data အရ New badge နဲ့ What’s this? description ပြပါ။
- [ ] Quantity ကို ၁ အောက် မဆင်းစေပါ။ Add to cart မှာ quantity × price တန်ဖိုး ချက်ချင်းပြောင်းပြီး tap feedback ပြပါ။
- [ ] Rewards မှာ local member record၊ tier ladder၊ points ring၊ Eat more earn more/Gift tabs နဲ့ challenges ပြပါ။ Rewards badge၊ Gift နဲ့ Earn အတွက် လိုအပ်တဲ့ visual feedback ထည့်ပါ။
- [ ] Register → Home → Product Detail integration test ရေးပြီး run ပါ။ Day 1 အဆုံးမှာ Home၊ Product Detail နဲ့ Rewards ကို ပုံတွေအပါအဝင် airplane mode နဲ့ စမ်းပါ။

## Day 2 — UI polish၊ motion၊ verification နဲ့ submission

### 5. Design fidelity နဲ့ required motion

**PDF စည်းကမ်း (pp. 1–2, 5, 8–14)** — Design states ၁၀ ခုနဲ့ နီးစပ်ရမယ်။ Name empty နဲ့ filled က route တစ်ခုရဲ့ states နှစ်ခုဖြစ်ပါတယ်။ Portrait 4.7–6.9 လက်မ၊ text scale 1.3 အထိ support ရမယ်။ Motion စာရင်းက အနည်းဆုံး လိုအပ်ချက်ပါ။

- [ ] Design states ၁၀ ခုကို reference နဲ့ spacing၊ type၊ colors၊ imagery နဲ့ layout တိုက်စစ်ပါ။ Shared theme tokens သုံးပါ။ UI strings ကို ARB + `gen-l10n` ထဲထားပါ။ Portrait screen အသေး/အကြီး၊ text scale 1.3 နဲ့ keyboard ဖွင့်ထားချိန် overflow စစ်ပါ။
- [ ] **Onboarding** — Donut circles drift in လုပ်ပြီး title နဲ့ buttons အချိန်ခြားကာ ဝင်လာပါစေ။
- [ ] **Registration** — Shared-axis သို့မဟုတ် slide transitions၊ progress ring 25% → 50% → 75% → 100% → checkmark ထည့်ပါ။ Input focus/error နဲ့ wrong OTP shake ကို animate လုပ်ပါ။
- [ ] **Buttons** — Press scale နဲ့ Continue က loading state သို့ ပြောင်းတဲ့ motion ထည့်ပါ။
- [ ] **Welcome** — Donut tiles အချိန်ခြားပြီး slide in လုပ်ကာ title fade up ဖြစ်ပါစေ။
- [ ] **Home / Product** — Skeleton shimmer၊ sections အချိန်ခြားပြီး ပေါ်လာခြင်း၊ carousel autoplay၊ product image Hero transition နဲ့ quantity number animation ထည့်ပါ။
- [ ] **Rewards** — Ring က 0 ကနေ member progress ဆီ sweep လုပ်ပြီး total 680,000 ထိ count-up လုပ်ပါ။ Silver → Gold → Platinum အစဉ်လိုက် ပေါ်ပြီး current tier highlight နဲ့ next-tier line fill ပြပါ။
- [ ] **Rewards tabs / challenges** — Moving tab indicator၊ card list transition နဲ့ card entrance အချိန်ခြားပါ။ Donut 1/4 နဲ့ 4/4 ကို အပိုင်းလိုက် အရောင်ဖြည့်ပြီး coffee arc 9/12 ပြပါ။ Ring နဲ့ progress art ကို `CustomPainter` သို့မဟုတ် Rive နဲ့ ဆွဲပါ။
- [ ] **Earn / badge / nav** — 4/4 ပြည့်ရင် Earn active နဲ့ attention cue၊ ကျန်ရင် grey state၊ tap feedback ပါစေ။ Rewards (3) badge pop နဲ့ Home ↔ Reward active pill slide ထည့်ပါ။
- [ ] Durations နဲ့ curves ကို motion file တစ်ခုထဲမှာ named constants ထားပါ။ Motion အများစုကို Flutter animation APIs နဲ့ရေးပါ။ `MediaQuery.disableAnimations` နဲ့ Reduce Motion အတွက် animations တိုစေခြင်း သို့မဟုတ် ကျော်ခြင်းကို စမ်းပါ။
- [ ] Mid-range Android ဖုန်းအစစ်မှာ profile mode နဲ့ animation frame timing တိုင်းပြီး 60 fps ရည်မှန်းချက်အတွက် jank စစ်ပါ။ Device မရသေးရင် ဒီ task ကို pending ထားပြီး limitation မှတ်ပါ။

### 6. နောက်ဆုံး quality gates

**PDF စည်းကမ်း (pp. 13–15)** — `flutter analyze` clean ဖြစ်ရမယ်။ `flutter_lints` သို့မဟုတ် `very_good_analysis`၊ နားလည်လွယ်တဲ့ names နဲ့ named constants သုံးပါ။ Functions ကို အကြမ်းဖျင်း ၂၀ လိုင်း၊ files ကို ၃၀၀ လိုင်းဝန်းကျင်အတွင်း ထိန်းပါ။ README အတိုင်း build မရခြင်း၊ main flow crash ဖြစ်ခြင်း၊ widgets ထဲမှာ app data hard-code လုပ်ခြင်းက တစ်ခုခုရှိရင် ချက်ချင်းကျနိုင်ပါတယ်။

- [ ] Fresh checkout မှာ README အတိုင်း dependency setup နဲ့ လိုအပ်တဲ့ code generation လုပ်ပြီး Android/iOS builds ပြန်ထုတ်ပါ။
- [ ] `flutter analyze`၊ unit/widget tests နဲ့ Register → Home → Product Detail integration test အားလုံး pass ဖြစ်ကြောင်း မှတ်ပါ။
- [ ] Android emulator နဲ့ iOS Simulator မှာ Register၊ Log out၊ Log in၊ relaunch၊ invalid inputs၊ product navigation နဲ့ Rewards tabs စမ်းပါ။ Back၊ double tap၊ OTP lock နဲ့ Resend ကိုပါ စစ်ပါ။
- [ ] Offline fresh install၊ အသုံးပြုပြီးမှ airplane mode ဝင်တာ၊ offline relaunch၊ connection ပြန်ရတာနဲ့ pull-to-refresh စစ်ပါ။ UI data က local database ကနေ လာပြီး images မြင်ရကြောင်း အတည်ပြုပါ။
- [ ] သတ်မှတ်ထားတဲ့ UI states နဲ့ motion ကို တစ်ပတ်လည် စမ်းပါ။ Public commit history နဲ့ source tree ထဲ client reference PDF/screenshots မပါကြောင်း ပြန်စစ်ပါ။

### 7. Submission items လေးခု

**PDF စည်းကမ်း (pp. 14–15)** — Test ပို့လာတဲ့ email ကို reply လုပ်ပြီး public repo၊ installable builds၊ recording နဲ့ README ပေးရမယ်။ AI coding tools သုံးလို့ရပြီး shortlist ဝင်ရင် ကိုယ်တင်ထားတဲ့ code ကို ရှင်းပြနိုင်ရမယ်။

Day 2 ရဲ့ နောက်ဆုံး **၃ နာရီ** ကို clean build၊ install verification၊ recording နဲ့ submission အတွက် ချန်ထားမယ်။

- [ ] **Public repo** — User ပေးတဲ့ GitHub/GitLab repo link ကို အသုံးပြုပြီး final commit နဲ့ readable commit history ရှိကြောင်း စစ်ပါ။ Reviewer က repo ဖွင့်လို့ရကြောင်း အတည်ပြုပါ။
- [ ] **Builds** — Android release `.apk` နဲ့ iOS Simulator `.app` zip ပြင်ပါ။ PDF မှာ `flutter build ios --simulator` ကို ဖော်ပြထားပါတယ်။ Simulator build အတွက် debug mode သုံးပြီး အမှန်တကယ် zip ဖြည်ကာ simulator မှာ install/launch စမ်းပါ။ Android APK ကိုလည်း install/launch စမ်းပါ။
- [ ] **Recording** — ၂–၄ မိနစ်အတွင်း Register → Log out → Log in → Home → Product Detail → Rewards ပြပါ။ တူညီတဲ့ flow ကို airplane mode မှာ ထပ်ပြပါ။ Offline register အတွက် မသုံးရသေးတဲ့ phone number တစ်ခု ပြင်ထားပါ။
- [ ] **README** — Run/setup၊ Flutter/Dart versions၊ architecture နဲ့ folder map၊ state management ရွေးရတဲ့အကြောင်း၊ offline strategy၊ animations၊ fake OTP၊ known gaps နဲ့ time spent ထည့်ပါ။ README instructions ကို fresh checkout နဲ့ verify လုပ်ပါ။
- [ ] Email reply အတွက် repo/README links၊ builds နဲ့ video attachments သို့မဟုတ် links ပြင်ပါ။ Link permissions နဲ့ artifact versions ကို စစ်ပါ။ Reply ပို့ပြီးကြောင်း အတည်ပြုပြီးမှ submission ကို sent အဖြစ် မှတ်ပါ။
- [ ] Walkthrough အတွက် auth ကို API နဲ့ ဘယ်လိုအစားထိုးမလဲ၊ database/refresh ဘယ်လိုအလုပ်လုပ်လဲ၊ motion နဲ့ tests ဘာကြောင့် ဒီလိုရေးထားလဲ ရှင်းပြနိုင်အောင် ပြန်ကြည့်ပါ။

## Bonus — Required tasks ပြည့်ပြီး အချိန်ကျန်မှ

- [ ] Persistent cart။
- [ ] Burmese locale။
- [ ] Minimum ထက်ပိုတဲ့ animation။
- [ ] CI မှာ analyzer နဲ့ tests run ခြင်း။
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
