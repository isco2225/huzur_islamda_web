# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Proje

Bu depo, "İbadet Rehberim" mobil uygulamasının tanıtım web sitesini
(ibadetrehberim.com) içerir. Site **Astro 7** ile inşa edilmiş, tamamen statik
ve varsayılan olarak sıfır client JS'li bir sitedir; kaynak kodu `astro-site/`
klasöründedir. Depoda başka proje yoktur.

Uygulamanın kendisi (Flutter) ayrı bir yerdedir ve bu depoyu ilgilendirmez.

## Doküman haritası (hangi soruda hangi dosya bağlayıcı)

| Dosya | Kapsam |
|---|---|
| **TASARIM.md** | Görsel tasarımın bağlayıcı şartnamesi: token'lar, tipografi, yüzey ritmi, Gün Döngüsü imza öğesi, animasyon bütçesi, yapılmayacaklar. Görsel bir karar vereceksen önce burayı oku. |
| **GORSELLER.md** | Hazır PNG varlıklarının envanteri, yerleşim planı, hazır `alt` metinleri. TASARIM.md §6.3'ü geçersiz kılar: mockup'lar HTML/CSS ile yeniden çizilmez. |
| **UYGULAMA_OZELLIKLERI.md** | Uygulama özellikleri hakkında içerik yazarken tek doğru kaynak. |
| **MIGRATION_NOTES.md** | Eski Flutter Web → Astro geçişinin envanteri; tarihsel referans. |

## Komutlar

```bash
cd astro-site
npm install       # Node >= 22.12 gerekir
npm run dev       # geliştirme sunucusu
npm run build     # üretim çıktısı → dist/
npm run preview   # dist/ önizlemesi
npx astro check   # tip/tanı kontrolü (@astrojs/check + TS strict)
```

Test altyapısı yoktur; doğrulama `npx astro check` + `npm run build` + görsel
inceleme ile yapılır. Test çerçevesi ekleme.

## Mimari

**Ana sayfa + üç özellik sayfası + üç yardımcı sayfa.** `index.astro` dokuz
bileşeni sırayla dizer
(Hero → VakitKusagi → NasilCalisir → Ozellikler → EkranSeridi → SSS → FinalCTA
→ Footer); bölümler kendi stilini kendi içinde taşır, sayfa yalnız sıralama
yapar. Bir bölüm eklemek/çıkarmak = `index.astro`'da bir satır.

Bilinmesi gereken, tek dosyaya bakınca görünmeyen bağlantılar:

- **Token → utility zinciri.** Tailwind v4 `@tailwindcss/vite` ile kuruludur;
  `tailwind.config` **yoktur**. Renkler `global.css` içindeki `@theme` bloğunda
  `--color-*` olarak tanımlıdır ve Tailwind bunlardan otomatik utility üretir
  (`--color-vurgu` → `bg-vurgu`, `text-vurgu`, `border-vurgu`). Yeni bir renk
  ancak `@theme`'e eklenirse sınıf olarak kullanılabilir; bileşene ham hex
  gömme. Ortak bileşen sınıfları (`.kapsayici`, `.bolum`, `.eyebrow`, `.golge`,
  `.cizgi`, `.rakam`) da `global.css` `@layer components` içindedir.
- **Mağaza URL'i tek kaynaktan.** `MagazaButonlari.astro` `playStoreUrl`'ü
  **export eder**; `index.astro` bunu JSON-LD `installUrl` için import eder.
  Linki değiştirirken iki yeri değil bu bir yeri güncelle. `appStoreUrl` boş
  string olduğu sürece App Store butonu "Yakında" pasif haline düşer — dolunca
  kendiliğinden aktifleşir.
- **Head genişletme.** `Base.astro` `title`/`description`/`ogType` props'u alır;
  canonical ve mutlak `og:image` URL'ini `astro.config.mjs`'teki `site`
  değerinden türetir (o değer değişirse tüm meta etiketleri değişir). Sayfaya
  özel head içeriği `<slot name="head">` ile geçer — ana sayfadaki JSON-LD
  böyle ekleniyor.
- **Hukuki sayfalar markdown'dır.** `privacy_policy.md` ve `terms_of_use.md`
  frontmatter'daki `layout:` ile `Legal.astro`'ya bağlanır ve
  `title`/`pageTitle`/`description`/`updated` alanlarını oradan besler. Metin
  tipografisi Legal.astro'nun scoped `:global()` stillerindedir.
- **Scroll-reveal sözleşmesi.** Bir öğeyi kademeli göstermek için `.reveal`
  sınıfı + `style="--gecikme: 0.2s"` yeterlidir; yatay şerit gibi çocukları
  ekran dışında kalan kapsayıcılarda ebeveyne `.reveal-grup` verilir (çocuklar
  soldan sağa otomatik kademelenir, 8 çocuğa kadar). Gizli başlangıç durumu
  yalnız `html.js` altında geçerlidir, dolayısıyla JS'siz içerik tamamen
  görünür. Yeni bir observer/script yazma, bu sınıfları kullan.
- **Ekran şeridi klasörden beslenir.** `EkranSeridi.astro`,
  `src/assets/gorseller/store/*.png`'i `import.meta.glob` ile eager toplar ve
  dosya adının kökünü (`01-vakitler`) `altYazilar` haritasındaki `alt` +
  `altYazi` ile eşler. Klasöre dosya eklemek şeride kart ekler; haritaya
  karşılığını yazmayı unutma.
- **Özellik sayfaları tek kalıptır.** `namaz-vakitleri`, `zikirmatik` ve
  `dua-hadis-ayet` aynı iskeleti izler: `GeriDon` → içerik bölümleri →
  `FinalCTA` → `Footer`, head slot'unda BreadcrumbList JSON-LD. İçerik yalnız
  UYGULAMA_OZELLIKLERI.md'nin ilgili bölümlerinden yazılır (her sayfanın
  frontmatter yorumunda kaynağı belirtilir) ve sayfalar birbirine gövde
  metninden linklenir. Yeni özellik sayfası bu kalıbı kopyalar.

### Klasörler

```
astro-site/src/
  layouts/     Base.astro (meta/OG/canonical/reveal), Legal.astro
  components/  Header, Hero, VakitKusagi, NasilCalisir, Ozellikler,
               EkranSeridi, SSS, FinalCTA, Footer, MagazaButonlari, GeriDon
  pages/       index.astro, namaz-vakitleri.astro, zikirmatik.astro,
               dua-hadis-ayet.astro, privacy_policy.md, terms_of_use.md,
               delete_account.astro, 404.astro
  styles/      global.css (@theme token'ları + tipografi + animasyon)
  assets/      app_icon.png, gorseller/ (mockup-*, kart-*, hero-*, akis-*,
               store/) — hepsi astro:assets <Image /> ile
astro-site/public/   robots.txt, app-ads.txt, favicon, icons/, og.png
gorseller/           Ham varlık deposu (GORSELLER.md envanteri)
```

## Kritik kurallar

- **URL'ler kırılmamalı:** `/privacy_policy` mağaza konsollarında kayıtlıdır.
  `/terms_of_use` ve `/delete_account` da yayında olan path'lerdir. Yeniden
  adlandırma yapma.
- **İç linkler `/` ile biter:** `astro-site/vercel.json` `trailingSlash: true`
  ayarlıdır; sayfalara verilen iç linkler `/namaz-vakitleri/` gibi eğik
  çizgiyle yazılır, yoksa Vercel 308 yönlendirmesi araya girer.
- **Hukuki metinler** (gizlilik politikası, kullanım koşulları) kelimesi
  kelimesine korunur; yeniden yazma, özetleme, "iyileştirme" yasak. Hata görsen
  bile olduğu gibi bırak, yalnızca not düş.
- **JavaScript bütçesi:** İki istisna vardır ve yenisi eklenmez:
  (1) `/delete_account` formunun EmailJS gönderim script'i (mağaza uyumluluğu
  için zorunlu; service/template ID'leri Flutter'daki
  `delete_account_screen.dart` ile aynıdır ve tasarımı gereği istemci
  tarafında açıktır), (2) `Base.astro`'daki ~1 KB'lik scroll-reveal script'i.
  React/Vue/Svelte gibi UI framework'leri ve animasyon kütüphaneleri eklenmez.
- **Uydurma bilgi yok:** Kodda/dokümanda olmayan bilgiyi (mağaza linki, e-posta,
  istatistik, yorum) icat etme; görünür `TODO:` bırak ve kullanıcıya sor.
  Sahte sosyal kanıt kesinlikle yasak.
- **Metin dili:** Türkçe, doğal ve konuşur gibi; slogan/aforizma kalıplarından
  kaçın. CSS `text-transform: uppercase` kullanma (İ/ı sorunu).
- **Kod dili de Türkçe:** Bileşen adları, props, CSS sınıfları ve değişkenler
  Türkçe yazılır (`varyant`, `kapsayici`, `--gecikme`, `altYazilar`). Yeni kod
  bu düzene uyar.

## Kalite çıtası (değişiklik sonrası doğrula)

1. `npm run build` hatasız; `npx astro check` temiz.
2. SEO: her sayfada tek `<h1>`, benzersiz title/description, canonical, OG
   etiketleri; sitemap çalışır durumda.
3. Görseller `astro:assets` `<Image />` ile; anlamlı `alt` (hazır metinler
   GORSELLER.md §3'te); AA kontrast; `:focus-visible` görünür.
4. Responsive: 360–1536px arasında yatay taşma yok; animasyonlar yalnız
   `transform`/`opacity` (CLS = 0) ve `prefers-reduced-motion`'a saygılı.
5. Hedef: Lighthouse 4 kategoride 95+; ana sayfa HTML+CSS ~100 KB altı
   (görseller hariç).

## Deploy

Vercel, GitHub entegrasyonu ile: `main`'e push edilen her commit otomatik
olarak canlıya (`ibadetrehberim.com`) çıkar. Elle deploy komutu yoktur;
`gh-pages` dönemi kapandı. Diğer branch'ler/PR'lar otomatik önizleme URL'i
alır. Proje ayarlarında Root Directory `astro-site`'tır.

**Commit/push onay kuralı:** Push canlı siteyi doğrudan etkilediği için
commit atmadan önce KULLANICIYA SOR: yapılan değişiklikleri özetle, commit
mesajını göster ve "bu commit ile push'layayım mı?" diye onay al. Onay
gelmeden commit/push yapma. Push'tan önce `npm run build` + `npx astro check`
lokalde temiz olmalı.

**Commit mesajları İngilizce** yazılır (emir kipi, kısa özet satırı; örn.
`Move deploy to Vercel`). Sitenin metin/kod dili Türkçe olsa da commit
geçmişi İngilizcedir.

## Bekleyen eksikler (kullanıcıdan)

- App Store URL'i → yayınlanınca `MagazaButonlari.astro` içindeki `appStoreUrl`
  doldurulacak (buton otomatik aktifleşir).
- Hukuki sayfalardaki iletişim bloğu placeholder (`destek@uygulamaadi.com`) —
  gerçek adres onayı bekliyor.
- Sosyal medya linkleri (varsa footer'a eklenecek).
