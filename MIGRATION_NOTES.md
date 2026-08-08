# MIGRATION_NOTES.md — Flutter Web → Astro Geçişi

Tarih: 2026-08-08 · Kaynak gerçeği: bu depodaki Flutter kodu (`lib/`, `assets/`, `web/`)

## 1. Rotalar / Sayfalar

Router: `go_router` (`lib/router/app_router.dart`). **URL stratejisi: PATH routing** —
`lib/main.dart:8` → `setUrlStrategy(PathUrlStrategy())`. Hash routing YOK, dolayısıyla
Aşama 3'teki hash-redirect script'ine gerek yok; path'ler birebir korunur.

| Path | Flutter ekranı | Astro karşılığı |
|---|---|---|
| `/` | `LandingScreen` (hero, özellikler, ekran görüntüleri, SSS, footer) | `src/pages/index.astro` |
| `/privacy_policy` | `PrivacyPolicyScreen` | `src/pages/privacy_policy.md` |
| `/terms_of_use` | `TermsOfUseScreen` | `src/pages/terms_of_use.md` |
| `/delete_account` | `DeleteAccountScreen` (EmailJS form) | `src/pages/delete_account.astro` |

Not: `lib/screens/home_screen.dart` router'a bağlı DEĞİL (kullanılmayan eski ekran) — taşınmadı.

**Korunması kritik URL:** Mağaza konsollarında büyük olasılıkla `/privacy_policy` kayıtlı.
Bu path Astro'da birebir aynıdır (`/privacy_policy` → `dist/privacy_policy/index.html`,
trailing-slash sunucu tarafından çözülür). Yayına alındıktan sonra mağaza konsollarındaki
politika URL'sini kontrol edin; temiz path zaten aynı olduğundan değişiklik gerekmiyor.

## 2. Metin içeriği eşleme tablosu

| İçerik | Kaynak Dart dosyası |
|---|---|
| Site başlığı "İbadet Rehberim" | `lib/app.dart:12`, `lib/widgets/app_app_bar.dart:45` |
| Hero başlık "İbadet Rehberiniz / Her Zaman Yanınızda" + alt metin | `lib/screens/landing_screen.dart` (`_HeroText`) |
| Mağaza buton etiketleri ("App Store'dan İndir", "Google Play'den Al") | `lib/screens/landing_screen.dart` (`_StoreButton`) |
| "Neden İbadet Rehberim?" + 4 özellik kartı | `lib/screens/landing_screen.dart` (`_FeaturesSection`) |
| "Uygulama İçinden" + 9 ekran görüntüsü | `lib/screens/landing_screen.dart` (`_ScreenshotsSection`) |
| "Sıkça Sorulan Sorular" — 6 soru/cevap | `lib/screens/landing_screen.dart` (`_FaqSection`) |
| Footer linkleri + telif satırı | `lib/widgets/landing_footer.dart` |
| Gizlilik Politikası (tam metin, 6 bölüm + yasal uyarı) | `lib/screens/privacy_policy_screen.dart` |
| Kullanım Koşulları (tam metin, 6 bölüm) | `lib/screens/terms_of_use_screen.dart` |
| Veri Silme Talebi formu metinleri | `lib/screens/delete_account_screen.dart` |
| Meta description (eski) | `web/index.html:22`, `web/manifest.json` |

Hukuki metinler **kelimesi kelimesine** taşındı. Kaynakta fark edilen ve OLDUĞU GİBİ
bırakılan noktalar (değiştirilmedi):
- Her iki hukuki sayfada iletişim bloğu placeholder içeriyor:
  `E-posta: destek@uygulamaadi.com` ve `Web Sitesi: Web Sitenizin Adresi`.
  → KULLANICIYA SORU: Gerçek e-posta `ibadetrehberim@gmail.com` mı olmalı? (Veri silme
  formu bu adrese gönderiyor.) Metin sahibi onaylarsa .md dosyalarında güncellenmeli.
- "Son Güncelleme Tarihi: 15 Şubat 2026" her iki sayfada aynen korundu.

## 3. Görsel kimlik

Kaynak: `lib/constants/app_colors.dart`, `lib/constants/app_theme.dart`, `web/manifest.json`.

| Token | Değer | Kullanım |
|---|---|---|
| primary | `#687d2a` (zeytin yeşili) | başlıklar, butonlar, kart çerçeveleri, linkler |
| background | `#faf9eb` (krem) | sayfa zemini (manifest `background_color` ile aynı) |
| surface | `#f5f5f5` | bölüm zeminleri (alpha 0.5 ile), bilgi kutuları |
| secondary | `#000000` | hukuki sayfalarda kalın ara başlıklar |
| subtitle | `rgba(0,0,0,0.87)` (black87) | gövde metni |
| error | `#b00020` | form hataları |
| footer zemini | primary alpha 0.08 | `landing_footer.dart` |

- Köşe yarıçapları: kartlar 16px, SSS 12px, butonlar 15px, form alanları 12px.
- **Font:** Özel font YOK (pubspec'te font tanımı yok, google_fonts kullanılmıyor; Flutter
  varsayılanı Roboto). Karar: CLAUDE.md'deki sade seçenek uyarınca **sistem font yığını**
  (CDN yok, self-host gereksiz). İstenirse `@fontsource/roboto` ile değiştirilebilir.
- Logo: `assets/icons/app_icon.png` (512px PNG). Favicon/ikonlar: `web/favicon.png`,
  `web/icons/Icon-*.png`. Ekran görüntüleri: `assets/app_screenshots/1..9 photo.jpg`.

## 4. Mağaza linkleri / iletişim / sosyal medya

- **Google Play / App Store URL'leri kodda YOK** — landing'deki mağaza butonları boş
  (`onPressed: () {}`). Astro'da butonlar `TODO` işaretli, `href="#"` + `aria-disabled`
  olarak kondu. → KULLANICIYA SORU: gerçek mağaza URL'leri nedir?
- **Sosyal medya linkleri kodda YOK** — footer'daki 3 ikon boş `onPressed`. Astro'ya
  taşınMADI (ölü link basmamak için). → KULLANICIYA SORU: sosyal medya hesapları var mı?
- Veri silme formu alıcısı: `ibadetrehberim@gmail.com` (EmailJS ile,
  `lib/screens/delete_account_screen.dart`): service `service_9sgvp6i`,
  template `template_7thm9mu`, public key `NYh4ChOPW2-Eo3i8M`. Aynı yapılandırma Astro
  sayfasına taşındı.

## 5. Aynen taşınan sunucu dosyaları

- `web/.well-known/` **yok** (assetlinks.json / apple-app-site-association bulunmadı).
- `web/CNAME` → `astro-site/public/CNAME` (içerik: `ibadetrehberim.com`; GitHub Pages
  özel alan adı için gerekli).
- `web/app-ads.txt` → `astro-site/public/app-ads.txt` (içeriği hâlâ placeholder/yorum;
  AdMob doğrulaması için gerçek satır eklenmeli → KULLANICIYA SORU).
- `web/favicon.png`, `web/icons/*` → `astro-site/public/` altına kopyalandı.
- `robots.txt` kaynakta yoktu → yeni oluşturuldu (Sitemap satırı ile).

## 6. Bilinçli sapmalar / kararlar

- **Veri silme formu için minimal inline JS**: CLAUDE.md "tek JS istisnası hash-redirect"
  der; ancak path routing kullanıldığından hash-redirect gerekmedi. Buna karşılık
  `/delete_account` formu EmailJS API'sine JSON POST gerektirir ve mağaza uyumluluğu için
  çalışır olmalıdır. Bu nedenle sitedeki TEK JavaScript, yalnızca bu sayfada bulunan
  framework'süz ~40 satırlık form gönderim script'idir. Diğer tüm sayfalarda JS sıfırdır.
- SSS ve mobil ekran görüntüsü şeridi: JS'siz çözümler (`<details>` ve yatay kaydırmalı
  `overflow-x` şerit; mobil karousel yerine kaydırılabilir şerit).
- Footer telif yılı build anında hesaplanır (Flutter'da `DateTime.now().year` idi).
- Kullanılmayan `HomeScreen` taşınmadı (router'da rotası yok).

## 7. Doğrulama sonuçları (Aşama 6)

Tarih: 2026-08-08 · Astro 7.2 · `npm run build` + `npx astro check`

1. **Build:** hatasız, 4 sayfa. `astro check`: 0 hata, 0 uyarı, 0 hint.
2. **İçerik gerçek HTML'de:** `grep -i "gizlilik" dist/index.html` eşleşiyor;
   `dist/privacy_policy/index.html` içinde "kullanıcılarımızın gizliliğine ve kişisel
   verilerinin güvenliğine büyük önem veriyoruz" ve "IDFA/GAID" birebir bulunuyor;
   `dist/terms_of_use/index.html` içinde "İstanbul (Merkez) Mahkemeleri..." bulunuyor.
3. **Preview:** `/`, `/privacy_policy`, `/terms_of_use`, `/delete_account`,
   `/robots.txt`, `/sitemap-index.xml`, `/og-image.png`, `/favicon.png` → hepsi HTTP 200.
   İç linkler doğru path'leri gösteriyor.
4. **Boyutlar:** ana sayfa HTML 17,7 KB + CSS 16,6 KB ≈ **34 KB** (hedef <100 KB ✓).
   `dist/` toplam 664 KB (optimize WebP görseller dahil; 1 MB'lık JPG'ler 10–39 KB'a indi).
5. **JS:** `/privacy_policy` ve `/terms_of_use` sayfalarında 0 script. Ana sayfadaki tek
   `<script>` JSON-LD (çalıştırılabilir JS değil). Sitedeki tek gerçek JS,
   `/delete_account` formunun inline gönderim script'i.
6. **SEO:** her sayfada tek `<h1>`, benzersiz `<title>` + description, canonical,
   OG/Twitter etiketleri; sitemap 4 URL içeriyor; ana sayfada `MobileApplication` JSON-LD.

## 8. Deploy

Mevcut düzen: GitHub Pages, `gh-pages` branşı (bkz. kökteki `makefile`), özel alan adı
`ibadetrehberim.com` (CNAME).

**Seçenek A — GitHub Pages (mevcut düzenin devamı):**
```bash
cd astro-site && npm run build
# dist/ içeriğini gh-pages branşına push edin (public/CNAME otomatik dist/'e kopyalanır)
npx gh-pages -d dist
```

**Seçenek B — Cloudflare Pages / Netlify / Vercel (önerilen):**
- Build command: `npm run build` · Output directory: `dist` · Root directory: `astro-site`

Yayın sonrası:
1. Google Search Console'a `https://ibadetrehberim.com/sitemap-index.xml` gönderin.
2. Mağaza konsollarındaki (Google Play / App Store Connect) gizlilik politikası URL'sinin
   `https://ibadetrehberim.com/privacy_policy` olduğunu doğrulayın (path birebir korundu).

## 9. Kullanıcıdan beklenen eksikler (TODO)

1. App Store ve Google Play mağaza URL'leri (hero'daki iki buton için).
2. Hukuki sayfalardaki iletişim e-postası: `destek@uygulamaadi.com` placeholder —
   gerçek adres onayı (muhtemelen `ibadetrehberim@gmail.com`).
3. Sosyal medya hesap linkleri (varsa; yoksa footer ikonsuz kalacak).
4. `app-ads.txt` gerçek AdMob satırı.
5. OG görseli için özel tasarım istenirse (şu an logo + marka renginden üretildi).
