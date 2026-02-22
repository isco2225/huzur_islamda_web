import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/app_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
                  'Gizlilik Politikası',
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
                Text(
                  'İbadet Rehberim ekibi olarak, kullanıcılarımızın gizliliğine ve kişisel verilerinin güvenliğine büyük önem veriyoruz. Bu Gizlilik Politikası, mobil uygulamamızı kullandığınızda verilerinizin nasıl toplandığını, kullanıldığını, paylaşıldığını ve korunduğunu açıklamaktadır.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text(
                  'Hizmetlerimizi kullanarak, bu politikada belirtilen uygulamaları kabul etmiş olursunuz.',
                  style: bodyStyle,
                ),
                SizedBox(height: isMobile ? 24 : 32),
                _SectionTitle(title: '1. Toplanan Veriler'),
                const SizedBox(height: 8),
                Text(
                  'Uygulamayı daha verimli kullanabilmeniz ve size kişiselleştirilmiş bir deneyim sunabilmek için aşağıdaki veri türlerini toplamaktayız:',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Kimlik ve İletişim Bilgileri:', style: boldStyle),
                Text(
                  'Hesap oluşturduğunuzda Ad, Soyad, E-posta adresi, doğum tarihi ve cinsiyet bilgilerinizi toplarız. Google veya Apple ile giriş yapmanız durumunda, ilgili platform tarafından sağlanan temel profil bilgilerinizi (ad, e-posta, profil fotoğrafı) işleriz.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Konum Bilgileri:', style: boldStyle),
                Text(
                  'Namaz vakitlerini doğru hesaplayabilmek için İlçe, Şehir ve Ülke bazlı konum verilerinizi toplarız. Bu veriler anlık GPS takibi şeklinde değil, seçtiğiniz veya onayladığınız lokasyon bilgisi olarak işlenir.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Kullanım ve İçerik Verileri:', style: boldStyle),
                Text(
                  'Oluşturduğunuz günlük zikirler, zikir sayılarınız ve "Ruh Haline Göre" oluşturulan zikir setleri. "Akış" (Flow) bölümünde kaydettiğiniz gönderiler (Kaydedilenler). Asistan ile yaptığınız sohbet geçmişi (bağlamı korumak adına son mesajlaşmalar).',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text('Reklam Verileri:', style: boldStyle),
                Text(
                  'Ücretsiz sürümü kullanıyorsanız, reklam gösterimi için cihaz reklam kimliği (IDFA/GAID) gibi tanımlayıcılar toplanabilir.',
                  style: bodyStyle,
                ),
                SizedBox(height: isMobile ? 24 : 32),
                _SectionTitle(title: '2. Verilerin Kullanım Amaçları'),
                const SizedBox(height: 8),
                Text(
                  'Topladığımız verileri şu amaçlarla kullanıyoruz:',
                  style: bodyStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  '• Hizmetin Sunulması: Namaz vakitlerini konumunuza göre hesaplamak, zikirlerinizi takip etmek ve kaydetmek.\n\n'
                  '• Hesap Yönetimi: Kimliğinizi doğrulamak, şifre sıfırlama işlemlerini yürütmek ve profilinizi yönetmenizi sağlamak.\n\n'
                  '• Kişiselleştirme: "Asistan" özelliğinin sorularınıza size özel (örneğin isminizle hitap ederek) yanıt vermesini sağlamak ve ana akışta ilgi alanlarınıza uygun içerikler sunmak.\n\n'
                  '• İletişim ve Bildirimler: Namaz vakti hatırlatmaları ve günlük zikir hatırlatmalarını (saat 22:00 gibi) size iletmek.\n\n'
                  '• Geliştirme ve Güvenlik: Uygulamanın hatalarını tespit etmek, güvenliği sağlamak ve kullanıcı deneyimini iyileştirmek.\n\n'
                  '• Reklam Gösterimi: Premium üye değilseniz, size uygun reklamları sunabilmek.',
                  style: bodyStyle,
                ),
                SizedBox(height: isMobile ? 24 : 32),
                _SectionTitle(title: '3. Verilerin Paylaşımı'),
                const SizedBox(height: 8),
                Text(
                  'Kişisel verilerinizi, yasal zorunluluklar veya hizmetin işleyişi haricinde üçüncü şahıslara satmayız. Verileriniz yalnızca aşağıdaki durumlarda paylaşılabilir:',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text(
                  '• Hizmet Sağlayıcılar: Uygulamanın altyapısını sağlayan güvenilir üçüncü taraf hizmetler (veritabanı ve kimlik doğrulama, reklam gösterimi vb.).\n\n'
                  '• Yasal Zorunluluklar: Kanunen yetkili kamu kurum ve kuruluşlarından gelen yasal talepler doğrultusunda verileriniz paylaşılabilir.\n\n'
                  '• Ödeme İşlemleri: Premium abonelik (Haftalık/Yıllık) satın alımlarınız Apple App Store veya Google Play Store ödeme sistemleri üzerinden gerçekleşir. Kredi kartı bilgileriniz sunucularımızda tutulmaz.',
                  style: bodyStyle,
                ),
                SizedBox(height: isMobile ? 24 : 32),
                _SectionTitle(title: '4. Veri Güvenliği'),
                const SizedBox(height: 8),
                Text(
                  'Verilerinizin güvenliği bizim için önceliklidir:',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text(
                  '• Verileriniz güvenilir bulut sunucularında saklanmaktadır.\n\n'
                  '• Uygulama ile sunucular arasındaki veri iletişimi şifreleme teknolojisi ile korunmaktadır.\n\n'
                  '• Zikir verileriniz gibi bazı tercihleriniz cihazınızda yerel olarak, cihaz güvenliğinize bağlı olarak saklanır.\n\n'
                  '• Hesabınıza erişim şifre korumalıdır. Şifrenizin güvenliğinden siz sorumlusunuz.',
                  style: bodyStyle,
                ),
                SizedBox(height: isMobile ? 24 : 32),
                _SectionTitle(title: '5. Haklarınız'),
                const SizedBox(height: 8),
                Text(
                  'Kullanıcı olarak kişisel verileriniz üzerinde aşağıdaki haklara sahipsiniz:',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text(
                  '• Erişim ve Düzeltme: Profil sayfanızdan kişisel bilgilerinizi (ad, soyad, konum vb.) dilediğiniz zaman görüntüleyebilir ve güncelleyebilirsiniz.\n\n'
                  '• Veri Silme (Unutulma Hakkı): Uygulama içerisindeki Ayarlar > Hesap > Hesabı Sil seçeneğini kullanarak hesabınızı ve ilişkili tüm verilerinizi kalıcı olarak silebilirsiniz. Ayrıca web sitemizdeki talep formunu kullanarak da silme talebinde bulunabilirsiniz.\n\n'
                  '• İtiraz ve Kısıtlama: Verilerinizin işlenmesine itiraz etme hakkınız saklıdır.\n\n'
                  '• Bildirimleri Kapatma: Ayarlar menüsünden namaz ve zikir bildirimlerini dilediğiniz zaman kapatabilirsiniz.',
                  style: bodyStyle,
                ),
                SizedBox(height: isMobile ? 24 : 32),
                _SectionTitle(title: '6. İletişim'),
                const SizedBox(height: 8),
                Text(
                  'Bu Gizlilik Politikası veya kişisel verilerinizle ilgili herhangi bir sorunuz, öneriniz veya talebiniz olması durumunda bizimle iletişime geçmekten çekinmeyin.',
                  style: bodyStyle,
                ),
                const SizedBox(height: 12),
                Text(
                  'E-posta: destek@uygulamaadi.com\n'
                  'Web Sitesi: Web Sitenizin Adresi',
                  style: bodyStyle,
                ),
                SizedBox(height: isMobile ? 24 : 32),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    'Yasal Uyarı: İbadet Rehberim uygulaması içerisindeki dini bilgiler, dualar ve yönlendirmeler genel bilgilendirme amaçlıdır ve fetva niteliği taşımaz. Dini konulardaki nihai sorumluluk kullanıcıya aittir.',
                    style: bodyStyle?.copyWith(fontStyle: FontStyle.italic),
                  ),
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
