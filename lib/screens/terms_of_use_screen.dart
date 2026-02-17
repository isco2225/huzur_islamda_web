import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/app_app_bar.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);
    final bodyStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      color: AppColors.subtitleColor,
      height: 1.5,
    );
    final boldStyle = bodyStyle?.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.secondary,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppAppBar(showBackButton: true),
      body: SingleChildScrollView(
        child: Responsive.constrainContent(
          context,
          child: Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kullanım Koşulları',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile
                        ? null
                        : (Theme.of(
                                    context,
                                  ).textTheme.headlineMedium?.fontSize ??
                                  28) *
                              1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Son Güncelleme Tarihi: 15 Şubat 2026',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.subtitleColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: isMobile ? 20 : 28),
                _SectionTitle(title: '1. Genel Hükümler'),
                const SizedBox(height: 8),
                Text(
                  'İbadet Rehberim uygulamasına hoş geldiniz. Bu uygulamayı indirerek veya kullanarak, bu kullanım koşullarını peşinen kabul etmiş sayılırsınız.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Hizmetin Tanımı:', style: boldStyle),
                Text(
                  'Uygulama; kullanıcılara namaz vakitleri takibi, zikirmatik, İslami içerik akışı ve yapay zeka destekli asistan hizmeti sunan bir mobil platformdur.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Dini İçerik Uyarısı:', style: boldStyle),
                Text(
                  'Uygulama içerisinde sunulan namaz vakitleri, kıble yönü, hadisler ve yapay zeka asistanı tarafından verilen yanıtlar yalnızca bilgilendirme ve yardımcı olma amaçlıdır. Bu bilgiler kesin dini hüküm (fetva) niteliği taşımaz. Dini vecibelerinizi yerine getirirken nihai doğrulama sorumluluğu kullanıcıya aittir.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Abonelikler:', style: boldStyle),
                Text(
                  'Uygulama, reklamsız kullanım gibi özellikler için ücretli abonelik paketleri (Haftalık/Yıllık) sunabilir. Ödemeler Apple App Store veya Google Play Store hesabınız üzerinden gerçekleştirilir ve ilgili mağazanın iptal/iade koşullarına tabidir.',
                  style: bodyStyle,
                ),
                SizedBox(height: isMobile ? 24 : 32),
                _SectionTitle(title: '2. Kullanıcı Yükümlülükleri'),
                const SizedBox(height: 8),
                Text(
                  'Uygulamayı kullanırken aşağıdaki hususlara uymayı taahhüt edersiniz:',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Hesap Güvenliği:', style: boldStyle),
                Text(
                  'Hesap oluştururken verdiğiniz bilgilerin (E-posta, Ad, Soyad vb.) doğru olduğunu beyan eder; şifrenizin güvenliğinden bizzat sorumlu olduğunuzu kabul edersiniz.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Uygun Kullanım:', style: boldStyle),
                Text(
                  '"Akış" (Flow) veya "Asistan" bölümlerinde yapacağınız etkileşimlerde, genel ahlaka, İslam adabına ve yasalara aykırı, hakaret içeren veya yanıltıcı içerik üretmemeyi/paylaşmamayı taahhüt edersiniz.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Kötüye Kullanım:', style: boldStyle),
                Text(
                  'Uygulamanın teknik yapısına zarar verecek, tersine mühendislik (reverse engineering) içeren veya sistemin açığını arayan faaliyetlerde bulunamazsınız.',
                  style: bodyStyle,
                ),
                SizedBox(height: isMobile ? 24 : 32),
                _SectionTitle(title: '3. Fikri Mülkiyet'),
                const SizedBox(height: 8),
                Text('Uygulama Hakları:', style: boldStyle),
                Text(
                  'İbadet Rehberim uygulamasının yazılımı, tasarımı, logosu, veritabanı yapısı ve oluşturulan özgün içeriklerin tüm mülkiyet hakları geliştiriciye aittir.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Dini Metinler:', style: boldStyle),
                Text(
                  'Uygulamada yer alan Kur\'an-ı Kerim ayetleri ve Hadis metinleri evrensel olup telif hakkına tabi değildir; ancak bu metinlerin derleniş biçimi, sunumu ve çeviri veritabanları uygulamanın fikri mülkiyetindedir.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Kullanım Lisansı:', style: boldStyle),
                Text(
                  'Size, uygulamayı yalnızca kişisel ve ticari olmayan amaçlarla kullanmanız için sınırlı, devredilemez bir lisans verilir. Uygulamanın bir kısmını veya tamamını kopyalamak, satmak veya izinsiz dağıtmak yasaktır.',
                  style: bodyStyle,
                ),
                SizedBox(height: isMobile ? 24 : 32),
                _SectionTitle(
                  title: '4. Hizmetin Değiştirilmesi veya Sona Ermesi',
                ),
                const SizedBox(height: 8),
                Text('Güncellemeler:', style: boldStyle),
                Text(
                  'Geliştirici, uygulamanın özelliklerini (örneğin Asistanın yeteneklerini veya zikir özelliklerini) dilediği zaman güncelleme, değiştirme veya kaldırma hakkını saklı tutar.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Fesih Hakkı:', style: boldStyle),
                Text(
                  'Kullanım koşullarına aykırı hareket eden kullanıcıların hesapları (özellikle uygunsuz içerik bildirimi veya raporlama durumlarında) haber verilmeksizin askıya alınabilir veya silinebilir.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Hizmetin Durdurulması:', style: boldStyle),
                Text(
                  'Geliştirici, teknik veya ticari sebeplerle uygulamanın yayınına geçici veya kalıcı olarak son verebilir.',
                  style: bodyStyle,
                ),
                SizedBox(height: isMobile ? 24 : 32),
                _SectionTitle(title: '5. Sorumluluk Sınırı'),
                const SizedBox(height: 8),
                Text('Teknik Hatalar:', style: boldStyle),
                Text(
                  'Namaz vakitleri hesaplamaları coğrafi konuma ve seçilen hesaplama yöntemine göre değişiklik gösterebilir. Uygulama, olası yazılımsal hatalardan, GPS sapmalarından veya vakit uyumsuzluklarından doğabilecek manevi sorumlulukları kabul etmez. Temkin sürelerini kontrol etmek kullanıcının sorumluluğundadır.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Yapay Zeka (Asistan):', style: boldStyle),
                Text(
                  'Uygulama içindeki asistan, yapay zeka teknolojisi ile çalışmaktadır. Verdiği yanıtların %100 doğruluğu garanti edilmez. Asistanın dini konulardaki yorumları referans alınarak ibadet değişikliğine gidilmemelidir.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Üçüncü Taraf Reklamlar:', style: boldStyle),
                Text(
                  'Uygulamanın ücretsiz sürümünde gösterilen reklamların içeriği reklam verenin sorumluluğundadır; geliştirici bu içeriklerden sorumlu tutulamaz.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Veri Kaybı:', style: boldStyle),
                Text(
                  'Cihazınızda veya sunucularda oluşabilecek teknik arızalar sonucu zikir sayacı veya kaydedilen gönderilerin kaybolmasından uygulama sorumlu değildir.',
                  style: bodyStyle,
                ),
                SizedBox(height: isMobile ? 24 : 32),
                _SectionTitle(title: '6. Uygulanacak Hukuk ve İletişim'),
                const SizedBox(height: 8),
                Text('Hukuk:', style: boldStyle),
                Text(
                  'İşbu Kullanım Koşulları\'ndan doğacak her türlü uyuşmazlıkta Türkiye Cumhuriyeti Kanunları uygulanacaktır.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Yetkili Mahkeme:', style: boldStyle),
                Text(
                  'Uyuşmazlıkların çözümünde İstanbul (Merkez) Mahkemeleri ve İcra Daireleri yetkilidir.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('İletişim:', style: boldStyle),
                Text(
                  'Uygulama ile ilgili her türlü soru, öneri, telif hakkı bildirimi veya hesap silme talepleriniz için bizimle aşağıdaki kanaldan iletişime geçebilirsiniz:',
                  style: bodyStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  'E-posta: destek@uygulamaadi.com\n'
                  'Web Sitesi: Web Sitenizin Adresi',
                  style: bodyStyle,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
