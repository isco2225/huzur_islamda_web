import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/app_app_bar.dart';
import '../widgets/landing_footer.dart';

/// Marketing landing page: Hero, Features, Screenshots, FAQ, Footer.
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppAppBar(showBackButton: false),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            _HeroSection(),
            _FeaturesSection(),
            _ScreenshotsSection(),
            _FaqSection(),
            LandingFooter(),
          ],
        ),
      ),
    );
  }
}

// --- Hero ---

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padH = Responsive.sectionHorizontalPadding(context);
    final padV = isMobile
        ? 48.0
        : (Responsive.isWideDesktop(context) ? 80.0 : 64.0);

    return Semantics(
      container: true,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
        child: Responsive.constrainLandingContent(
          context,
          child: isMobile
              ? _HeroColumn(context: context, isMobile: true)
              : _HeroRow(context: context),
        ),
      ),
    );
  }
}

class _HeroColumn extends StatelessWidget {
  const _HeroColumn({required this.context, required this.isMobile});

  final BuildContext context;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _HeroText(context: this.context, isMobile: isMobile),
        const SizedBox(height: 32),
        _AppMockupPlaceholder(isMobile: isMobile),
        const SizedBox(height: 28),
        _StoreButtons(isMobile: isMobile),
      ],
    );
  }
}

class _HeroRow extends StatelessWidget {
  const _HeroRow({required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: _HeroText(context: this.context, isMobile: false),
          ),
        ),
        SizedBox(width: Responsive.isWideDesktop(context) ? 64 : 48),
        const _AppMockupPlaceholder(isMobile: false),
        SizedBox(width: Responsive.isWideDesktop(context) ? 56 : 40),
        const Expanded(flex: 2, child: _StoreButtonsColumn()),
      ],
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText({required this.context, required this.isMobile});

  final BuildContext context;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'İbadet Rehberiniz\nHer Zaman Yanınızda',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            height: 1.2,
            fontSize: isMobile
                ? 28
                : (Responsive.isWideDesktop(context) ? 44 : 38),
          ),
        ),
        SizedBox(height: isMobile ? 16 : 20),
        Text(
          'Kur\'an ve sünnet ışığında namaz vakitleri, akıllı zikirmatik, dua-hadis-Kur\'an içerikleri ve İslami asistan ile ibadetlerinizi düzenli tutun. Ücretsiz indirin.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.subtitleColor,
            height: 1.55,
            fontSize: isMobile ? null : 17,
          ),
        ),
      ],
    );
  }
}

class _AppMockupPlaceholder extends StatelessWidget {
  const _AppMockupPlaceholder({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final isWide = !isMobile && Responsive.isWideDesktop(context);
    final phoneW = isMobile ? 120.0 : (isWide ? 160.0 : 140.0);
    final phoneH = isMobile ? 240.0 : (isWide ? 320.0 : 280.0);
    return Container(
      width: phoneW,
      height: phoneH,
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 20 : 28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.12),
            blurRadius: isWide ? 28 : 22,
            offset: Offset(0, isWide ? 12 : 10),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isMobile ? 20 : 28),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/icons/app_icon.png',
              width: phoneW * 0.7,
              height: phoneW * 0.7,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.smartphone,
                size: phoneW * 0.6,
                color: AppColors.primary.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoreButtons extends StatelessWidget {
  const _StoreButtons({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        _StoreButton(
          label: "App Store'dan İndir",
          icon: Icons.apple,
          onPressed: () {},
        ),
        _StoreButton(
          label: "Google Play'den Al",
          icon: Icons.play_circle_filled,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _StoreButtonsColumn extends StatelessWidget {
  const _StoreButtonsColumn();

  @override
  Widget build(BuildContext context) {
    final minW = Responsive.isWideDesktop(context) ? 220.0 : 200.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: minW,
          child: _StoreButton(
            label: "App Store'dan İndir",
            icon: Icons.apple,
            onPressed: () {},
          ),
        ),
        SizedBox(height: Responsive.isWideDesktop(context) ? 14 : 12),
        SizedBox(
          width: minW,
          child: _StoreButton(
            label: "Google Play'den Al",
            icon: Icons.play_circle_filled,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class _StoreButton extends StatelessWidget {
  const _StoreButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 22, color: AppColors.primary),
      label: Text(
        label,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    );
  }
}

// --- Features ---

class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection();

  @override
  Widget build(BuildContext context) {
    final padH = Responsive.sectionHorizontalPadding(context);
    final isMobile = Responsive.isMobile(context);
    final isWide = Responsive.isWideDesktop(context);
    final padV = isMobile ? 48.0 : (isWide ? 80.0 : 64.0);

    return Semantics(
      container: true,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: padV, horizontal: padH),
        color: AppColors.surface.withValues(alpha: 0.5),
        child: Responsive.constrainLandingContent(
          context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Neden İbadet Rehberim?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? null : (isWide ? 32 : 28),
                ),
              ),
              SizedBox(height: isMobile ? 28 : (isWide ? 48 : 40)),
              LayoutBuilder(
                builder: (context, constraints) {
                  const gap = 20.0;
                  const gapWide = 24.0;
                  final featureCards = [
                    _FeatureCard(
                      icon: Icons.schedule,
                      title: 'Namaz Vakitleri',
                      description:
                          'İlçe seçimiyle 6 vakit (İmsak, Güneş, Öğle, İkindi, Akşam, Yatsı), kalan süre ve hatırlatma bildirimleri.',
                    ),
                    _FeatureCard(
                      icon: Icons.repeat,
                      title: 'Akıllı Zikirmatik',
                      description:
                          'Günlük zikirler; manuel, namaz sonrası veya ruh haline göre oluşturma, sayma, takip ve 22:00 hatırlatması.',
                    ),
                    _FeatureCard(
                      icon: Icons.menu_book,
                      title: 'Dua, Hadis ve Kur\'an',
                      description:
                          'Dua, hadis ve Kur\'an ayetleri bir arada; kaydedebilir, detayını okuyabilir ve asistanla sohbeti sürdürebilirsiniz.',
                    ),
                    _FeatureCard(
                      icon: Icons.chat_bubble_outline,
                      title: 'Asistan',
                      description:
                          'İslami konularda soru sorup cevap alabilir, sohbet edebilirsiniz; okuduğunuz bir içerikten de sohbeti başlatabilirsiniz.',
                    ),
                  ];
                  if (isMobile) {
                    return Column(
                      children: [
                        for (var i = 0; i < featureCards.length; i++) ...[
                          if (i > 0) const SizedBox(height: gap),
                          featureCards[i],
                        ],
                      ],
                    );
                  }
                  final gapBetween = Responsive.isWideDesktop(context)
                      ? gapWide + 8
                      : gapWide;
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: featureCards[0]),
                          SizedBox(width: gapBetween),
                          Expanded(child: featureCards[1]),
                        ],
                      ),
                      SizedBox(height: gapBetween),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: featureCards[2]),
                          SizedBox(width: gapBetween),
                          Expanded(child: featureCards[3]),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final isWide = Responsive.isWideDesktop(context);
    return Card(
      elevation: 0,
      color: AppColors.background,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(isWide ? 28 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: isWide ? 44 : 40, color: AppColors.primary),
            SizedBox(height: isWide ? 20 : 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: isWide ? 17 : null,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.subtitleColor,
                height: 1.45,
                fontSize: isWide ? 15 : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Screenshots ---

class _ScreenshotsSection extends StatelessWidget {
  const _ScreenshotsSection();

  @override
  Widget build(BuildContext context) {
    final padH = Responsive.sectionHorizontalPadding(context);
    final isMobile = Responsive.isMobile(context);
    final isWide = Responsive.isWideDesktop(context);
    final padV = isMobile ? 48.0 : (isWide ? 80.0 : 64.0);

    return Semantics(
      container: true,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: padV, horizontal: padH),
        child: Responsive.constrainLandingContent(
          context,
          child: Column(
            children: [
              Text(
                'Uygulama İçinden',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? null : (isWide ? 32 : 28),
                ),
              ),
              SizedBox(height: isMobile ? 24 : (isWide ? 40 : 32)),
              isMobile
                  ? SizedBox(
                      height: 320,
                      child: PageView(
                        children: [
                          _ScreenshotPlaceholder(index: 1),
                          _ScreenshotPlaceholder(index: 2),
                          _ScreenshotPlaceholder(index: 3),
                          _ScreenshotPlaceholder(index: 4),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 340,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: _ScreenshotPlaceholder(index: 1)),
                          const SizedBox(width: 12),
                          Expanded(child: _ScreenshotPlaceholder(index: 2)),
                          const SizedBox(width: 12),
                          Expanded(child: _ScreenshotPlaceholder(index: 3)),
                          const SizedBox(width: 12),
                          Expanded(child: _ScreenshotPlaceholder(index: 4)),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScreenshotPlaceholder extends StatelessWidget {
  const _ScreenshotPlaceholder({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone_android,
                size: 48,
                color: AppColors.primary.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 8),
              Text(
                'Ekran Görüntüsü $index',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.subtitleColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'assets/screenshots/screen_$index.png',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.subtitleColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- FAQ ---

class _FaqSection extends StatelessWidget {
  const _FaqSection();

  static const _questions = [
    'İbadet Rehberim ücretsiz mi?',
    'Namaz vakitleri nasıl hesaplanıyor?',
    'Premium (destek paketi) nedir?',
    'İçerikler fetva veya hukuki karar niteliğinde mi?',
    'Verilerim nerede tutuluyor?',
    'Hangi cihazlarda çalışır?',
  ];
  static const _answers = [
    'Evet. Uygulama ücretsizdir; uygulama içinde reklamlar bulunabilir. Haftalık veya yıllık destek paketi (premium) ile reklamsız kullanabilirsiniz.',
    'Namaz vakitleri, Diyanet İşleri Başkanlığının belirlediği hesaplama yöntemiyle hazırlanır ve seçtiğiniz ilçeye göre hesaplanır. İmsak, Güneş, Öğle, İkindi, Akşam ve Yatsı vakitleri liste halinde gösterilir; bir sonraki vakte kalan süre her dakika güncellenir. Hatırlatma bildirimleri ayarlardan açılıp kapatılabilir.',
    'Haftalık ve yıllık destek paketleri mevcuttur. Premium kullanıcılar uygulama içinde reklam görmez.',
    'Hayır. Uygulamadaki tüm içerikler genel bilgilendirme amaçlıdır; dini veya hukuki açıdan nihai karar mercii değildir. Sorumluluk kullanıcıya aittir.',
    'Zikir ve tercih verileriniz cihazınızda saklanır; isterseniz bulutta yedekleyip farklı cihazlardan aynı verilere ulaşabilirsiniz. Giriş, profil ve hesap bilgileriniz güvenli sunucularda tutulur. Detaylar için Gizlilik Politikası sayfamıza bakın; veri silme talebinde bulunabilirsiniz.',
    'İbadet Rehberim iOS (iPhone/iPad) ve Android cihazlarda kullanılabilir. Arayüz ve mesajlar Türkçedir.',
  ];

  @override
  Widget build(BuildContext context) {
    final padH = Responsive.sectionHorizontalPadding(context);
    final isMobile = Responsive.isMobile(context);
    final isWide = Responsive.isWideDesktop(context);
    final padV = isMobile ? 48.0 : (isWide ? 80.0 : 64.0);

    return Semantics(
      container: true,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: padV, horizontal: padH),
        color: AppColors.surface.withValues(alpha: 0.5),
        child: Responsive.constrainLandingContent(
          context,
          child: Column(
            children: [
              Text(
                'Sıkça Sorulan Sorular',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? null : (isWide ? 32 : 28),
                ),
              ),
              SizedBox(height: isMobile ? 24 : (isWide ? 40 : 32)),
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isMobile ? double.infinity : 640,
                  ),
                  child: Column(
                    children: List.generate(_questions.length, (i) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: i < _questions.length - 1 ? 10 : 0,
                        ),
                        child: _FaqTile(
                          question: _questions[i],
                          answer: _answers[i],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.question, required this.answer});

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.background,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        title: Text(
          question,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Text(
              answer,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.subtitleColor,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
