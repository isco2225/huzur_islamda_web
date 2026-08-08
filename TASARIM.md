# TASARIM.md — İbadet Rehberim Web Sitesi Tasarım Şartnamesi

Bu dosya sitenin **bağlayıcı** tasarım şartnamesidir; görsel kararlarda genel
varsayımlarla çeliştiğinde bu dosya kazanır. İçerik/SEO/performans kuralları
için CLAUDE.md, hazır görsel varlıkların kullanımı için GORSELLER.md geçerlidir.
Aşağıdaki sistem sitede uygulanmıştır; yeni bir bölüm ya da sayfa eklenirken
buradaki kurallara uyulur.

---

## 1. Ruh

**Tek cümlelik tez:** Site, kullanıcıya bağırmaz; uygulamanın vaat ettiği şeyi —
sükûneti ve düzeni — kendi tasarımıyla kanıtlar.

- Az renk, bol boşluk, tipografi öncelikli, huzurlu.
- Sayfadaki en yüksek ses, uygulamanın kendi ekranlarıdır (hazır PNG'ler).
  Dekorasyon değil, kanıt gösterilir.
- Modernlik süsle değil düzenle kurulur: net yüzey ritmi, keskin hiyerarşi,
  ölçülü hareket.

## 2. Renk sistemi (kilitli)

Token'lar `global.css` içindeki `@theme` bloğunda tanımlıdır; değerler uygulama
ekranlarından örneklenmiştir ve `gorseller/` varlıklarıyla dikişsiz eşleşir.
Bileşenlere ham hex gömülmez.

| Token | Değer | Kullanım |
|---|---|---|
| `--color-zemin` | `#FAF8EB` | sayfa arka planı (uygulama kremi) |
| `--color-yuzey` | `#FFFFFF` | kartlar, beyaz bantlar, SSS kabı |
| `--color-murekkep` | `#20221A` | ana metin, koyu butonlar |
| `--color-soluk` | `#4C5545` | ikincil metin (zemin üstünde ~7:1) |
| `--color-vurgu` | `#677D2A` | zeytin yeşili: butonlar, hap etiketler |
| `--color-vurgu-koyu` | `#16431A` | linkler, hover/aktif, başlık vurgusu |
| `--color-detay` | `#B9944A` | sıcak altın: yalnız ince çizgiler/kenarlar |
| `--color-gece` | `#0E1B2A` | final CTA + footer zemini |

Kurallar:
- Sayfa genelinde **1 vurgu + 1 detay** rengi; üçüncü bir süs rengi yok.
- Uygulamadaki kırmızı (#B5001D) sitede kullanılmaz (yalnız ekran içeriğinde
  görünebilir). Form hata rengi `#B00020` yalnız formda.
- Metin kontrastı en az WCAG AA (≥4.5:1); ikincil metinde ~7:1 hedeflenir.
- Mor-pembe SaaS gradyanı, cam-morfizm, neon **yasak**.

## 3. Tipografi

- **Başlıklar:** Lora 600 (h1–h3, sakin bir serif; marka adında da kullanılır).
- **Gövde:** Manrope 400/500. Fontlar `@fontsource` ile self-host,
  `font-display: swap`, yalnız bu üç ağırlık.
- Akışkan ölçek: `h1: clamp(2.4rem, 5vw + 1rem, 4rem)` ·
  `h2: clamp(1.75rem, 3vw + 0.75rem, 2.5rem)` · gövde 1–1.125rem, satır 1.6–1.7.
- Rakamlarda (vakit saatleri) `font-variant-numeric: tabular-nums` (`.rakam`).
- H1'de tek bir anahtar ifade `--color-vurgu-koyu` ile renklendirilebilir
  ("sade bir rehber" gibi); birden fazla vurgu yapılmaz.
- **Türkçe:** CSS `text-transform: uppercase` kullanılmaz (İ/ı sorunu).
  ğ, ş, ı, İ, ö, ü, ç glifleri her yeni metinde kontrol edilir.

## 4. Yüzey ritmi ve tanım (sitenin "şık"lık omurgası)

Sayfa, krem ve beyaz tam genişlik bantların dönüşümüyle akar; bölümler zemine
karışmaz:

```
krem (Nav + Hero + Vakit Kuşağı)
→ beyaz bant (Nasıl çalışır)      ← ince altın çizgilerle sınırlı
→ krem (Özellikler)
→ beyaz bant (Ekranlar)
→ krem (SSS — beyaz kart kabında)
→ gece (Final CTA + Footer)
```

- **Kart tanımı:** beyaz yüzey + 1px `detay` %28 kenar + **tek, çok hafif,
  renksiz gölge** (`.golge`). İkinci gölge katmanı ya da renkli gölge yok.
- **Eyebrow:** her bölüm başında hap (pill) biçimli küçük etiket — `vurgu` %10
  zemin, %22 kenar, tam yuvarlak.
- Köşeler: kartlar 20px, akış bandı kabı 24px, hap/buton 999px.
- İçerik genişliği `max-width: 1120px` (`.kapsayici`), yatay padding
  `clamp(1.25rem, 4vw, 2.5rem)`; bölüm dikey ritmi
  `padding-block: clamp(4rem, 10vw, 7rem)` (`.bolum`).
- Hazır görsel kartlarına (GORSELLER.md) site tarafında ek gölge/kenar/köşe
  **uygulanmaz** — çerçeve ve gölge görselin içindedir.

## 5. İmza öğesi: Vakit Yayı

Sitenin hatırlanacağı tek özgün öğe. Hero'nun altında, güneşin gökyüzündeki
yolunu çizen bir diyagram — namaz vakitleri zaten güneşin konumuyla tanımlanır;
öğe bu gerçeği görselleştirir. Tamamı inline SVG + CSS; görsel dosyası yok
(`VakitKusagi.astro`).

- **İnce ufuk çizgisi** (uçları geceye kararan gradyan) ve üzerinde güneşin
  doğuştan batışa **yayı** (gradyan: `#22335A → #E8A45C → #F1C77A →
  #D89A55 → #22335A`).
- **Vakit yerleşimi anlamlıdır:** Güneş ve Akşam ufuk üstünde (doğuş/batış),
  Öğle yayın tepesinde, İkindi inişte; **İmsak ve Yatsı ufkun gece tarafında**
  (lacivert noktalar, soluk etiketler).
- Gündüz noktaları krem + koyu halka, gece noktaları lacivert + krem halka.
- **Güneş animasyonu:** küçük haleli güneş, yayı 60 sn'de bir kez kateder
  (SMIL `animateMotion`); `prefers-reduced-motion`'da hareketli güneş gizlenir,
  sabit güneş gösterilir.
- Noktalar görünüme girerken İmsak'tan Yatsı'ya kademeli belirir.
- Karşılığında sayfada başka dekoratif gradyan, desen, illüstrasyon **yoktur**.
  (Gece bölümü düz koyu zemindir, gradyan değildir.)

## 6. Sayfa akışı (index)

**Nav → Hero → Vakit Kuşağı → Nasıl çalışır → Özellikler (+ zikir akış bandı)
→ Ekranlar → SSS → Final CTA → Footer**

- **Nav:** yapışkan, 64px, yarı saydam krem + blur, altın hairline; solda logo +
  isim (Lora), sağda 3 çapa + tek "İndir" butonu (tam yuvarlak, vurgu).
- **Hero:** solda rozet hapları (yalnız doğrulanmış gerçekler), tez cümlesi H1
  (tek renkli vurgu ifadesiyle), kısa alt metin, mağaza butonları
  (koyu dolgu; App Store pasifken "Yakında"), küçük dürüst not. Sağda
  `mockup-vakitler.png` — eager + `fetchpriority="high"`, ekstra çerçevesiz.
- **Nasıl çalışır:** beyaz bant; "Önce / Sonra / Gün boyu" etiketli üç sütun,
  üst hairline'lı. Görünür numara (01/02) kullanılmaz — sıra bilgisini yalnız
  Vakit Kuşağı taşır.
- **Özellikler:** 4 kart; fiil öncelikli başlık + 1–2 doğal cümle + kartın
  içinde küçük HTML/CSS demo (gerçek içerikle). İstisna: zikir özelliği demo
  yerine bölüm sonundaki **akış bandı** (`akis-zikir.png`, çerçeveli beyaz kap,
  mobilde yatay kaydırma) ile anlatılır. İkonlar tek set inline SVG (Lucide
  çizgi stili); emoji ikon yasak.
- **Ekranlar:** beyaz bant; 6 küratörlü kart, CSS-only `scroll-snap` şeridi,
  kısa alt yazılar. Sıra ve alt metinler GORSELLER.md'den.
- **SSS:** beyaz kart kabında `<details>/<summary>` akordeon; 6 gerçek soru,
  cevaplar uygulamadan birebir.
- **Final CTA + Footer:** `--color-gece` zemininde ikon + tek cümle + butonların
  açık varyantı; footer'da açıklama, ürün/hukuki linkler, telif. Sosyal kanıt
  bölümü yalnız gerçek veri olursa eklenir; **uydurma istatistik/yorum yasak.**

## 7. Animasyon bütçesi (tavan — yenisi eklenmez)

Hareket ölçülüdür; şu dört kalem bütçenin tamamıdır:

1. **Hero girişi:** rozetler → H1 → alt metin → butonlar/mockup, 100 ms arayla,
   yalnız ilk yüklemede (saf CSS `belir` animasyonu).
2. **Kademeli scroll-reveal:** öğeler `opacity 0→1` + `translateY(16px)→0`,
   600 ms, `cubic-bezier(0.16, 1, 0.3, 1)`. Kademe `--gecikme` ile: başlıklar
   80 ms, kartlar 100 ms, adımlar 120 ms, SSS 70 ms arayla; yatay şeritte
   ebeveyn tetiklemeli `.reveal-grup` (soldan sağa 80 ms). Tetikleyici ~1 KB
   vanilla `IntersectionObserver`; gizli başlangıç yalnız `html.js` altında —
   **JS'siz içerik tamamen görünür.**
3. **Hover mikro etkileşimleri:** butonlarda koyulaşma + 1px kalkış, kartlarda
   kenar belirginleşmesi + 2px kalkış; 150–250 ms.
4. **Vakit Yayı güneşi** (§5): yay boyunca 60 sn'lik yolculuk.

Kurallar: yalnız `transform` ve `opacity` (CLS = 0); `prefers-reduced-motion:
reduce` durumunda tümü kapalı, içerik doğrudan görünür. **Yasak:** parallax,
imleç takibi, otomatik video, sonsuz dikkat çekiciler, animasyon kütüphaneleri
(GSAP/AOS/Framer vb.), bu listeye yeni animasyon kalemi eklemek.

## 8. Responsive

- Mobile-first; kırılımlar `640 / 768 / 1024px`.
- Hero `<1024px` tek sütun (mockup altta, `min(85%, 360px)`); `≥1024px`
  `7fr/5fr` iki sütun.
- Ekran şeridi ve akış bandı mobilde kenardan kenara / yatay kaydırmalı;
  masaüstünde konteynerle hizalı. Akış bandı görseli 860px altına küçülmez
  (okunabilirlik), kaydırılır.
- Dokunma hedefleri ≥44×44px; buton metinleri kısaltılmaz, sarar.
- Doğrulama genişlikleri: **360, 390, 768, 1024, 1280, 1536px** — taşma, kırık
  satır ve CLS kontrolü.

## 9. Kalite çıtası ve öz-eleştiri

- Görünür `:focus-visible`, anlamlı `alt` (hazır metinler GORSELLER.md'de),
  semantik başlık hiyerarşisi, AA kontrast.
- Hedef ve mevcut durum: Lighthouse ≥95 (ölçülen: 99/100/100/100), CLS 0,
  ana sayfa HTML+CSS ~100 KB altı, en büyük görsel çıktısı ~50 KB webp.
- Bitirmeden önce "aynaya bak, bir aksesuar çıkar": işlevi olmayan süsü sil.
- Öz-test: Bu sayfa herhangi bir SaaS şablonuna benziyor mu? Vakit Kuşağı'nı
  kaldırsam kimlik kalıyor mu? Cevaplar "hayır/evet" değilse revize et.

## 10. Yapmayacaklar (özet)

Stok fotoğraf ve hazır 3D illüstrasyon · üçüncü vurgu rengi · mor-pembe
gradyan, neon, cam-morfizm · sahte sosyal kanıt · otomatik uppercase Türkçe
başlık · emoji ikon · animasyon kütüphanesi · parallax · ikinci dekoratif
gradyan/desen · bütçe dışı yeni animasyon · hazır görsel kartlarına çift
gölge/çift köşe · slogan-aforizma kalıbında metin (doğal, konuşur gibi yazılır).
