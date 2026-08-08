# TASARIM.md — İbadet Rehberim Web Sitesi Tasarım Yönü

Bu dosya, `CLAUDE.md`'deki geçiş görevinin **tasarım şartnamesidir**. Aşama 1'e (kurulum) geçmeden önce okunur. Görsel tasarım konularında bu dosya bağlayıcıdır; genel varsayımlarla çeliştiğinde bu dosya kazanır. İçerik/SEO/performans kuralları için CLAUDE.md geçerliliğini korur.

---

## 1. Ruh ve referanslar

**Tek cümlelik tez:** Site, kullanıcıya bağırmaz; uygulamanın vaat ettiği şeyi — sükûneti ve düzeni — kendi tasarımıyla kanıtlar.

- **Yapı referansı:** minimatod.com (Astro ile yapılmış). İskeleti: ince yapışkan menü → rozetli hero + canlı mockup → "nasıl çalışır" → mini demolu özellik kartları → final CTA → hukuki linkli footer. Bu akışı uyarla, kopyalama.
- **Ton referansı:** thepillarsapp.com. Az renk, bol boşluk, tipografi öncelikli, huzurlu.
- **Genel ilke:** Sayfadaki en yüksek ses, uygulamanın kendi ekranları olmalı. Dekorasyon değil, kanıt göster.

## 2. Renk sistemi

### 2.1 Önce gerçek marka renkleri
CLAUDE.md Aşama 0'da Flutter'dan çıkarılan `ThemeData` / `Color(0xFF...)` değerleri **birincil kaynaktır**. Bu renkleri aşağıdaki token'lara eşle. Uygulama ile site aynı aileden görünmek zorunda.

### 2.2 Token sistemi (CSS custom properties, `global.css`)
```css
:root {
  --zemin: ...;          /* sayfa arka planı — açık, kırık beyaz */
  --yuzey: ...;          /* kart/menü yüzeyi */
  --murekkep: ...;       /* ana metin */
  --metin-soluk: ...;    /* ikincil metin */
  --vurgu: ...;          /* marka rengi: butonlar, linkler */
  --vurgu-koyu: ...;     /* hover/aktif durum */
  --detay: ...;          /* ince çizgiler, vakit noktaları için sıcak metal ton */
  --gece: ...;           /* koyu bölüm zemini (final CTA / footer) */
}
```
Tailwind kullanılıyorsa bu token'ları `@theme` üzerinden Tailwind renklerine bağla; ham hex'leri bileşenlere gömme.

### 2.3 Yedek palet (yalnızca Flutter'dan net palet çıkarılamazsa)
- `--zemin: #F7F6F2` · `--yuzey: #FFFFFF` · `--murekkep: #1C2B27` · `--metin-soluk: #5C6B66`
- `--vurgu: #14594A` (derin zümrüt) · `--vurgu-koyu: #0C3D33` · `--detay: #C29A4B` (altın — yalnız ince detaylarda) · `--gece: #0E1B2A`

### 2.4 Kurallar
- Sayfa genelinde **1 vurgu rengi + 1 detay rengi**. Üçüncü bir "süs" rengi yok.
- Metin kontrastı WCAG AA (≥ 4.5:1). Vurgu zemin olduğunda üstündeki metni test et.
- Mor-pembe SaaS gradyanı, cam-morfizm, neon vurgular **yasak** — bu sitenin dünyası değil.

## 3. Tipografi

- **Birinci tercih:** Flutter projesinde `google_fonts` ile tanımlı bir yazı tipi varsa, marka sürekliliği için onu sürdür (başlık ya da gövde rolünde) ve eksik rolü aşağıdan tamamla.
- **Yedek eşleşme:** Başlıklar **Lora** (600; sakin, insani bir serif — maneviyata modern bir dille eşlik eder) · Gövde **Manrope** (400/500) · Vakit saatleri gibi rakamlarda `font-variant-numeric: tabular-nums`.
- Fontlar `@fontsource` ile self-host, `font-display: swap`, yalnız gerekli ağırlıklar (CLAUDE.md Aşama 5 ile uyumlu).
- **Akışkan ölçek (clamp):** `h1: clamp(2.4rem, 5vw + 1rem, 4rem)` · `h2: clamp(1.75rem, 3vw + 0.75rem, 2.5rem)` · gövde `1rem–1.125rem`, satır yüksekliği 1.6–1.7, gövde satır uzunluğu 60–70 karakter.
- **Türkçe uyarısı:** CSS `text-transform: uppercase` kullanma (İ/ı dönüşümü riskli). Başlıkları elle, normal harf düzeniyle yaz. Tüm başlık ve rozetlerde ğ, ş, ı, İ, ö, ü, ç glifleri kontrol edilecek.

## 4. Boşluk, ritim, yüzeyler

- İçerik genişliği: `max-width: 1120px`, yatay padding `clamp(1.25rem, 4vw, 2.5rem)`.
- Bölüm dikey ritmi: `padding-block: clamp(4rem, 10vw, 7rem)`. Sıkışıklık, bu sitenin düşmanı.
- Köşeler: kartlar 20px, rozet/butonlar tam yuvarlak (999px). Yumuşaklık = dinginlik.
- Gölge yerine öncelik: 1px ince ayırıcı çizgiler (`--detay` %20 opaklık). Gölge gerekiyorsa tek, çok hafif, renksiz.

## 5. İmza öğesi: "Vakit Kuşağı"

Sitenin hatırlanacağı **tek** özgün öğe. Günün altı vakti (İmsak, Güneş, Öğle, İkindi, Akşam, Yatsı) yatay bir gökyüzü şeridi üzerinde: gece lacivertinden şafak turuncusuna, gündüz aydınlığına, ikindi ambarına, akşam kızıllığına ve tekrar geceye akan bir CSS gradyanı; her vakit ince bir nokta ve adıyla işaretli.

- Konumu: Hero'nun hemen altında, tam genişlikte ince bir bölüm (yükseklik ~120–160px) **veya** hero arka planının alt kenarına işlenmiş şerit. Birini seç, ikisini birden yapma.
- Uygulaması saf CSS (`linear-gradient` + flex noktalar). Görsel dosyası yok.
- Opsiyonel nefes: 60 sn'lik çok yavaş gradyan kayması (`background-position` animasyonu); `prefers-reduced-motion`'da kapalı.
- Bu öğe süs değil, anlam taşıyor: uygulamanın özü günün ritmidir; sayfa bunu yapısıyla söylüyor.
- Karşılığında geri kalan her şey sessiz kalır: başka dekoratif gradyan, desen, illüstrasyon **yok**.

## 6. Sayfa akışı (index)

Sıra: **Nav → Hero → Vakit Kuşağı → Nasıl çalışır → Özellikler → Ekran şeridi → (varsa) Sosyal kanıt → SSS → Final CTA → Footer**

### 6.1 Nav
Yapışkan, ince (64px), yarı saydam zemin + `backdrop-filter: blur`. Solda logo + isim, sağda 3–4 çapa linki ve tek "İndir" butonu. Mobilde çapa linkleri gizlenebilir; menü gerekiyorsa önce CSS-only (`details` tabanlı) çözüm.

### 6.2 Hero
```
Masaüstü (2 sütun)                     Mobil (tek sütun)
┌────────────────────┬──────────┐      ┌──────────────┐
│ [rozetler]         │          │      │  [rozetler]  │
│ H1 — tek cümle tez │  telefon │      │  H1          │
│ kısa alt metin     │  mockup  │      │  alt metin   │
│ [AppStore][Play]   │          │      │  [rozetler]  │
│ küçük not          │          │      │  mockup %85  │
└────────────────────┴──────────┘      └──────────────┘
```
- Rozet satırı: yalnızca **doğrulanmış** gerçekler (ör. "Ücretsiz · Reklamsız · Türkçe" — Flutter kodundan/kullanıcıdan teyitli olanlar).
- H1 bir tez cümlesi; özellik listesi değil. Örnek kalıp (içeriğe göre yeniden yaz): "İbadetin ritmi, cebinizde." Abartı ve pazarlama klişesi yok.
- Mağaza butonları resmi rozet görselleriyle; ikisi yan yana, mobilde alt alta sığmazsa sarar.

### 6.3 Telefon mockup tekniği
Minimatod yaklaşımı **tercih edilir**: uygulamanın ana ekranını HTML/CSS ile yeniden çiz (çerçeve + durum çubuğu + Flutter'daki gerçek ana ekran içeriği). Keskin, hafif ve her yoğunlukta net. Zaman kısıtında kabul edilebilir alternatif: gerçek ekran görüntüsünü `astro:assets` `<Image />` ile kullanmak. İçerik her iki durumda da gerçek uygulamadan; temsili sahte içerik üretme.

### 6.4 Nasıl çalışır + Özellikler
- Her bölüm başında küçük bir eyebrow etiketi + güçlü, kısa bir H2 (minimatod'un kalıbı: "Tek desen. Her proje." gibi ritimli cümleler — Türkçe ve bu uygulamaya özgü yaz).
- Özellik kartları: her kartta fiil öncelikli başlık ("Vaktinde uyan", "Kıbleni bul", "Zikrini say" gibi — **gerçek özelliklerden** türet) + 1–2 cümle + kartın içinde küçük bir görsel demo (arayüz parçası, HTML/CSS ile). İkon setinde tutarlılık: tek set inline SVG (ör. Lucide); emoji ikon olarak kullanılmaz.
- Kartlarda numaralandırma (01/02/03) kullanma — özellikler bir sıra değil. Sıra bilgisi taşıyan tek yer Vakit Kuşağı'dır.

### 6.5 Ekran şeridi
3–5 gerçek ekran görüntüsü, yatay kaydırmalı `scroll-snap` şeridi (CSS-only). Her görsele kısa alt yazı.

### 6.6 Sosyal kanıt
Yalnızca gerçek veri varsa (indirme sayısı, mağaza puanı, gerçek yorum). Yoksa bölümü tamamen atla. **Uydurma istatistik ve sahte yorum kesinlikle yasak.**

### 6.7 SSS
`<details>/<summary>` ile CSS-only akordeon. 4–6 gerçek soru (izinler, ücret, çevrimdışı çalışma, veri gizliliği gibi — CLAUDE.md envanterinden türet).

### 6.8 Final CTA + Footer
Final CTA `--gece` zemininde: uygulama ikonu + tek cümle + mağaza rozetleri. Footer aynı koyu zeminde: kısa açıklama, ürün linkleri, **Gizlilik Politikası / Kullanım Koşulları** (CLAUDE.md'deki korunan path'lere), iletişim, telif satırı.

## 7. Animasyon rehberi ("hafif"in tanımı)

**Bütçe:** (1) hero giriş dizisi, (2) bölümlerin scroll ile belirmesi, (3) hover mikro etkileşimleri. Bu üçü dışında animasyon yok.

- Hero girişi: başlık → alt metin → butonlar → mockup, 80–120ms arayla yukarı kayarak belirir (toplam < 1 sn, yalnızca ilk yüklemede).
- Scroll-reveal: bölümler `opacity 0→1` + `translateY(16px)→0`, süre 500–600ms, easing `cubic-bezier(0.16, 1, 0.3, 1)`.
- Hover: butonlarda hafif koyulaşma + 1–2px kalkış, kartlarda çizgi/başlık vurgusu; 150–250ms.
- **Uygulama tekniği (kritik):** İçerik JS olmadan da tamamen görünür olmalı. Gizli başlangıç durumu yalnızca `<html>` öğesine script ile `js` sınıfı eklendikten sonra uygulanır (`html.js .reveal { ... }`); tetikleyici ~1 KB'lik vanilla `IntersectionObserver`. Bu script, CLAUDE.md'nin sıfır-JS kuralının **ikinci ve son istisnasıdır** (ilki hash-redirect).
- `prefers-reduced-motion: reduce` durumunda tüm animasyonlar ve Vakit Kuşağı nefesi kapatılır; içerik doğrudan görünür.
- Yalnızca `transform` ve `opacity` animle (CLS = 0 korunmalı). **Yasak:** parallax, imleci takip eden öğeler, otomatik oynayan video, sonsuz döngülü dikkat çekiciler, animasyon kütüphaneleri (GSAP/AOS/Framer vb.).

## 8. Responsive kurallar

- Mobile-first CSS; kırılımlar: `640px`, `768px`, `1024px`.
- Hero: `<768px` tek sütun (metin üstte, mockup altta ~%85 genişlik, `max-width: 360px`); `≥1024px` iki sütun.
- Dokunma hedefleri ≥ 44×44px; buton metinleri mobilde kısalmaz, sarar.
- Ekran şeridi mobilde kenardan kenara (`scroll-padding` ile), masaüstünde konteyner içinde.
- Doğrulama genişlikleri: **360, 390, 768, 1024, 1280, 1536px** — her birinde taşma, kırık satır ve CLS kontrolü. `npm run preview` üzerinde gez.

## 9. Kalite çıtası ve öz-eleştiri

- Duyurmadan yap: görünür klavye odağı (`:focus-visible`), tüm görsellere anlamlı `alt`, semantik başlık hiyerarşisi, AA kontrast.
- Animasyonlar Lighthouse 95+ hedefini bozamaz (CLAUDE.md Aşama 6 geçerli).
- Bitirmeden önce "aynaya bak, bir aksesuar çıkar": sayfayı gez, işlevi olmayan bir süsü bul ve sil.
- Öz-test soruları: Bu sayfa herhangi bir SaaS şablonuna benziyor mu? Vakit Kuşağı'nı kaldırsam sayfanın kimliği kalıyor mu? İki cevaptan biri "hayır" değilse ilgili bölümü revize et.

## 10. Yapmayacaklar (özet)

Stok fotoğraf ve hazır 3D illüstrasyon paketleri · üçüncü bir vurgu rengi · mor-pembe gradyan, neon, cam-morfizm · sahte sosyal kanıt · otomatik uppercase Türkçe başlık · emoji ikonlar · animasyon kütüphanesi · parallax · dekoratif ikinci desen/gradyan (imza öğesi tektir).