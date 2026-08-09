# İbadet Rehberim — Tanıtım Web Sitesi

"İbadet Rehberim" mobil uygulamasının tanıtım sitesi (ibadetrehberim.com).
Site, [Astro](https://astro.build) ile inşa edilmiş tamamen statik bir sitedir;
kaynak kodu `astro-site/` klasöründedir.

## Geliştirme

```bash
cd astro-site
npm install
npm run dev       # geliştirme sunucusu
npm run build     # üretim çıktısı → dist/
npm run preview   # dist/ önizlemesi
```

## Sayfalar

| Path | İçerik |
|---|---|
| `/` | Ana sayfa (hero, Gün Döngüsü, özellikler, SSS) |
| `/privacy_policy` | Gizlilik Politikası |
| `/terms_of_use` | Kullanım Koşulları |
| `/delete_account` | Veri Silme Talebi formu |

`/privacy_policy` path'i mağaza konsollarında kayıtlıdır; değiştirilmemelidir.

## Deploy

GitHub Pages (`gh-pages` branşı, özel alan adı `ibadetrehberim.com` — CNAME
`astro-site/public/` altındadır):

```bash
cd astro-site && npm run build && npx gh-pages -d dist
```

Tasarım şartnamesi için `TASARIM.md`, geçiş envanteri için `MIGRATION_NOTES.md`
dosyalarına bakın.
