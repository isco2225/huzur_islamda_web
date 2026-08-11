# İbadet Rehberim — Tanıtım Web Sitesi

"İbadet Rehberim" mobil uygulamasının tanıtım sitesi (ibadetrehberim.com).
Site, [Astro](https://astro.build) ile inşa edilmiş tamamen statik bir sitedir;
kaynak kodu `astro-site/` klasöründedir.

## Geliştirme

```bash
cd astro-site
npm install       # Node >= 22.12 gerekir
npm run dev       # geliştirme sunucusu
npm run build     # üretim çıktısı → dist/
npm run preview   # dist/ önizlemesi
npx astro check   # tip/tanı kontrolü
```

## Sayfalar

| Path | İçerik |
|---|---|
| `/` | Ana sayfa (hero, Gün Döngüsü, özellikler, SSS) |
| `/namaz-vakitleri/` | Özellik sayfası: namaz vakitleri |
| `/zikirmatik/` | Özellik sayfası: zikirmatik |
| `/dua-hadis-ayet/` | Özellik sayfası: dua, hadis ve ayet içerikleri |
| `/privacy_policy` | Gizlilik Politikası |
| `/terms_of_use` | Kullanım Koşulları |
| `/delete_account` | Veri Silme Talebi formu |

`/privacy_policy` path'i mağaza konsollarında kayıtlıdır; değiştirilmemelidir.

## Deploy

Vercel, GitHub entegrasyonu ile: `main`'e push edilen her commit otomatik
olarak canlıya (`ibadetrehberim.com`) çıkar; elle deploy komutu yoktur. Diğer
branch'ler/PR'lar otomatik önizleme URL'i alır. Proje ayarlarında Root
Directory `astro-site`'tır.

Tasarım şartnamesi için `TASARIM.md`, görsel envanteri için `GORSELLER.md`,
geçiş envanteri için `MIGRATION_NOTES.md` dosyalarına bakın.
