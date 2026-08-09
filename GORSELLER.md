# GORSELLER.md — Hazır Web Görselleri Kullanım Kılavuzu

Bu depoda, siteye hazır **bitmiş görsel varlıklar** var: uygulamanın gerçek ekran görüntüleri temizlendi (durum/gezinme çubukları kaldırılıp sade bir durum çubuğu eklendi), modern telefon çerçevesine yerleştirildi ve marka renkleriyle kompoze edildi. Görevin bunları **entegre etmek**; yeniden üretmek, yeniden çizmek veya HTML/CSS mockup ile değiştirmek değil.

**Konum:** Depo kökünde `gorseller/` klasörü. Aşama 2'de içeriği `astro-site/src/assets/gorseller/` altına kopyala. Tek istisna: `hero/og-arkaplan.png` → `astro-site/public/og.png` olarak kopyalanır.

**Bu dosya TASARIM.md'nin §6.3 maddesini günceller:** "HTML/CSS ile yeniden çiz" tercihi artık geçersizdir — birincil yol bu hazır PNG'lerdir.

---

## 1. Envanter

| Dosya | Boyut | İçerik |
|---|---|---|
| `mockup-seffaf/mockup-vakitler.png` | 985×1962, şeffaf | Ezan vakitleri ekranı, çerçeveli, yumuşak gölge dahil |
| `mockup-seffaf/mockup-zikir-sayac.png` | 985×1962, şeffaf | Zikirmatik (Sübhanallah 50/100 halkası) |
| `mockup-seffaf/mockup-asistan.png` | 985×1962, şeffaf | Yapay zekâ asistan sohbet ekranı |
| `mockup-seffaf/mockup-zikirlerim.png` | 985×1962, şeffaf | Günlük zikir listesi ve ilerleme çubukları |
| `mockup-seffaf/mockup-kesfet.png` | 985×1962, şeffaf | Keşfet akışı (hadis/dua kartları) |
| `mockup-seffaf/mockup-gonderi.png` | 985×1962, şeffaf | Gönderi detayı (Arapça metin + açıklama) |
| `mockup-seffaf/mockup-zikir-menu.png` | 985×1962, şeffaf | Zikir hızlı menüsü (oluştur / ruh haline göre / namaz için) |
| `mockup-seffaf/mockup-zikir-tesbihat.png` | 985×1962, şeffaf | Namaz Tesbihatı onay penceresi (33'lük üç zikir) |
| `kart/kart-vakitler.png` | 1200×1600 | Vakitler ekranı, **şafak gradyanı** zeminli kart |
| `kart/kart-*.png` (diğer 7) | 1200×1600 | İlgili ekran, krem/zeytin marka zeminli kart |
| `hero/hero-safak.png` | 2400×1700 | Üç telefonlu yelpaze, şafak zeminli |
| `hero/hero-seffaf.png` | 2400×1700, şeffaf | Aynı yelpaze, zeminsiz (yedek/alternatif) |
| `hero/og-arkaplan.png` | 1200×630 | Sosyal paylaşım görseli; sol yarısı bilinçli boş |
| `akis/akis-zikir.png` | 3200×1400 | **Zikir akışı bandı:** menü → tesbihat onayı → liste → sayaç, oklarla bağlı 4 telefon, marka zeminli |
| `akis/akis-zikir-seffaf.png` | 3200×1400, şeffaf | Aynı akış, zeminsiz (alternatif) |

Kartlarda köşe yuvarlaklığı (36px) ve gölge **görselin içindedir**.

## 2. Yerleşim planı (TASARIM.md eşlemesi)

1. **Hero (§6.2):** Sağ sütunda `mockup-vakitler.png`. Şeffaf olduğu için krem zeminde doğrudan durur; arkasına ekstra zemin/çerçeve ekleme. `loading="eager"` + `fetchpriority="high"`.
2. **Ekran şeridi (§6.5):** 6 kart, `scroll-snap` şeridinde. Önerilen sıra: vakitler → zikir-sayac → asistan → zikirlerim → kesfet → gonderi. Görüntüleme genişliği ~360–420px, `loading="lazy"`.
3. **Özellik kartları (§6.4):** Kural değişmedi — mini demolar HTML/CSS ile yapılır; bu görseller orada kullanılmaz (aynı ekranların sitede iki kez büyük boy görünmesini engellemek için). Tek istisna: madde 6'daki zikir akışı.
4. **`hero-safak.png` (opsiyonel):** En fazla **tek** yerde: final CTA'nın hemen üstünde tam genişlik vitrin bandı olarak. Kullanmamak da geçerli bir karar; kullanılırsa başka hiçbir bölümde tekrar etme.
5. **`og.png`:** `BaseLayout` içinde `og:image` ve `twitter:image` olarak **mutlak URL** ile (`https://ibadetrehberim.com/og.png`).
6. **Zikir akışı bandı (`akis/akis-zikir.png`):** Zikir özelliğinin anlatıldığı yerde tam genişlik kullanılır — "Nasıl çalışır" içinde kendi alt bölümü olarak ya da özellikler bölümünde zikir satırının görseli olarak. Bu bandı kullanınca zikir için ayrıca HTML/CSS mini demo yapılmaz; band, özelliğin dört adımlık hikâyesini zaten anlatıyor. Mobilde bandı yatay kaydırmalı göster (`overflow-x` + `scroll-snap`) ki telefonlar okunaksız küçülmesin; masaüstünde konteynerden hafif taşan tam genişlik yerleşim serbest. `kart-zikir-menu` ve `kart-zikir-tesbihat` yedektir: şerit (§6.5) altı kartlık küratörlü halinde kalır, bu ikisi ancak kullanıcı isterse şeride eklenir.

## 3. Teknik kurallar

- Tüm görseller `astro:assets` `<Image />` bileşeniyle kullanılır; `width/height` her zaman tanımlı (CLS = 0). Format dönüşümünü (webp/avif) Astro'ya bırak; dosyaları elle kırpma, filtreleme, yeniden adlandırma yok.
- Kartlara site tarafında **ek gölge, kenarlık veya border-radius uygulama** — çift gölge/çift köşe hatası olur. Hover'da yalnız hafif `translateY` serbest.
- Şeritte kartlar arası boşluk `1.25–1.5rem`; mobilde kenardan kenara taşan şerit (TASARIM §8).

### Renk kilidi (ekranlardan örneklenmiş gerçek değerler)
TASARIM.md §2.3'teki yedek palet artık kullanılmaz; §2.2 token'larına şu değerler girilir (Flutter kodundan da çapraz doğrula):

```css
--zemin: #FAF8EB;        /* uygulama krem zemini */
--vurgu: #677D2A;        /* zeytin yeşili (birincil) */
--vurgu-koyu: #16431A;   /* koyu orman yeşili */
--gece: #0E1B2A;         /* koyu bölümler */
--murekkep: #20221A;
```
Uygulamadaki kırmızı (#B5001D) sitede **kullanılmaz** (yalnız ekran içeriğinde görünür).

### Şafak gradyanı (Gün Döngüsü ile birebir uyum)
`kart-vakitler` ve `hero-safak` bu duraklarla üretildi. **Gün Döngüsü'nün şafak katmanında aynı durakları kullan** ki görsellerle site dikişsiz eşleşsin:

```css
background: linear-gradient(180deg,
  #0E1B2A 0%, #2E3A5C 45%, #966962 72%, #E8B04B 92%, #F1C77A 100%);
```

### Hazır alt metinleri
- `mockup-vakitler` / `kart-vakitler`: "İbadet Rehberim ezan vakitleri ekranı: günün altı vakti ve sonraki vakte kalan süre"
- `kart-zikir-sayac`: "Zikirmatik ekranı: Sübhanallah zikrinde 50/100 ilerleme halkası"
- `kart-asistan`: "Yapay zekâ asistan ekranı: dua, hadis ve İslami sorular için sohbet"
- `kart-zikirlerim`: "Zikirlerim ekranı: günlük zikir hedefleri ve ilerleme çubukları"
- `kart-kesfet`: "Keşfet akışı: hadis ve dua kartları"
- `kart-gonderi`: "Gönderi detayı: Arapça metniyle birlikte bir dua ve Türkçe açıklaması"
- `hero-safak`: "İbadet Rehberim uygulamasının üç ekranı: zikirmatik, ezan vakitleri ve asistan"
- `kart-zikir-menu`: "Zikir menüsü: zikir oluştur, ruh haline göre zikirler ve namaz için zikirler seçenekleri"
- `kart-zikir-tesbihat`: "Namaz Tesbihatı penceresi: 33'er kez Subhanallah, Elhamdulillah ve Allahu Ekber oluşturma"
- `akis-zikir`: "Zikir akışı: menüden Namaz Tesbihatı seçimi, oluşan zikir listesi ve zikirmatik sayacı"

## 4. Bitti sayılma ölçütleri

`npm run preview`'da: hero'da vakitler mockup'ı eager yükleniyor ve yerleşim kayması yok; şeritte 6 kart doğru sırayla kayıyor; `view-source`'ta `og:image` mutlak URL; Lighthouse hedefleri (CLAUDE.md Aşama 6) korunuyor. Görsellerle ilgili bir sorun (bozuk dosya, eksik klasör) varsa uydurma çözüm üretme, kullanıcıya bildir.
