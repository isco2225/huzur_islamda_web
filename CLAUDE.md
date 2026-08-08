# CLAUDE.md — İbadet Rehberim Web Sitesi

## Proje

Bu depo, "İbadet Rehberim" mobil uygulamasının tanıtım web sitesini
(ibadetrehberim.com) içerir. Site **Astro** ile inşa edilmiş tamamen statik bir
sitedir; kaynak kodu `astro-site/` klasöründedir. Depoda başka proje yoktur.

Uygulamanın kendisi (Flutter) ayrı bir yerdedir ve bu depoyu ilgilendirmez.
Uygulama özellikleri hakkında içerik gerekirse kaynak: `UYGULAMA_OZELLIKLERI.md`.
Eski Flutter Web → Astro geçişinin envanteri ve kararları: `MIGRATION_NOTES.md`
(tarihsel referans).

## Komutlar

```bash
cd astro-site
npm run dev       # geliştirme sunucusu
npm run build     # üretim çıktısı → dist/
npm run preview   # dist/ önizlemesi
npx astro check   # tip/tanı kontrolü
```

## Yapı

```
astro-site/
  src/
    layouts/      Base.astro (meta/OG/canonical), Legal.astro (hukuki sayfalar)
    components/   Header, Hero, TelefonMockup, VakitKusagi, NasilCalisir,
                  Ozellikler, EkranSeridi, SSS, FinalCTA, Footer, MagazaButonlari
    pages/        index.astro, privacy_policy.md, terms_of_use.md, delete_account.astro
    styles/       global.css (token sistemi + tipografi + animasyon kuralları)
    assets/       app_icon.png, screenshots/ (astro:assets ile kullanılır)
  public/         CNAME, robots.txt, app-ads.txt, favicon, ikonlar, og-image
```

## Tasarım

Görsel tasarım kararlarında depo kökündeki **TASARIM.md bağlayıcıdır** (token
sistemi, tipografi, Vakit Kuşağı imza öğesi, animasyon bütçesi, yapılmayacaklar).
Renk token'ları `global.css` içindeki `@theme` bloğunda tanımlıdır; bileşenlere
ham hex gömme. Fontlar (@fontsource: Lora 600, Manrope 400/500) self-host'tur;
CDN kullanma.

## Kritik kurallar

- **URL'ler kırılmamalı:** `/privacy_policy` mağaza konsollarında kayıtlıdır.
  `/terms_of_use` ve `/delete_account` da yayında olan path'lerdir. Yeniden
  adlandırma yapma.
- **Hukuki metinler** (gizlilik politikası, kullanım koşulları) kelimesi
  kelimesine korunur; yeniden yazma, özetleme, "iyileştirme" yasak. Hata görsen
  bile olduğu gibi bırak, yalnızca not düş.
- **JavaScript bütçesi:** Site varsayılan olarak sıfır client JS'tir. İki istisna
  vardır ve yenisi eklenmez: (1) `/delete_account` formunun EmailJS gönderim
  script'i (mağaza uyumluluğu için zorunlu), (2) `Base.astro`'daki ~1 KB'lik
  scroll-reveal script'i (`html.js` kapılı; içerik JS'siz de tamamen görünür).
  React/Vue/Svelte gibi UI framework'leri ve animasyon kütüphaneleri eklenmez.
- **Uydurma bilgi yok:** Kodda/dokümanda olmayan bilgiyi (mağaza linki, e-posta,
  istatistik, yorum) icat etme; görünür `TODO:` bırak ve kullanıcıya sor.
  Sahte sosyal kanıt kesinlikle yasak.
- **Metin dili:** Türkçe, doğal ve konuşur gibi; slogan/aforizma kalıplarından
  kaçın. CSS `text-transform: uppercase` kullanma (İ/ı sorunu).

## Kalite çıtası (değişiklik sonrası doğrula)

1. `npm run build` hatasız; `npx astro check` temiz.
2. SEO: her sayfada tek `<h1>`, benzersiz title/description, canonical, OG
   etiketleri; sitemap çalışır durumda.
3. Görseller `astro:assets` `<Image />` ile; anlamlı `alt`; AA kontrast;
   `:focus-visible` görünür.
4. Responsive: 360–1536px arasında yatay taşma yok; animasyonlar yalnız
   `transform`/`opacity` (CLS = 0) ve `prefers-reduced-motion`'a saygılı.
5. Hedef: Lighthouse 4 kategoride 95+; ana sayfa HTML+CSS ~100 KB altı
   (görseller hariç).

## Deploy

GitHub Pages, `gh-pages` branşı, özel alan adı `ibadetrehberim.com`
(CNAME `astro-site/public/` altında):

```bash
cd astro-site && npm run build && npx gh-pages -d dist
```

## Bekleyen eksikler (kullanıcıdan)

- App Store URL'i → yayınlanınca `MagazaButonlari.astro` içindeki `appStoreUrl`
  doldurulacak (buton otomatik aktifleşir).
- Hukuki sayfalardaki iletişim bloğu placeholder (`destek@uygulamaadi.com`) —
  gerçek adres onayı bekliyor.
- Sosyal medya linkleri (varsa footer'a eklenecek).
- `app-ads.txt` gerçek AdMob satırı.
