import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/app_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final logoSize = Responsive.homeLogoSize(context);
    final isMobile = Responsive.isMobile(context);

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: isMobile ? 16 : 32),
        Image.asset(
          'assets/icons/app_icon.png',
          height: logoSize,
          width: logoSize,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.mosque,
            size: logoSize,
            color: AppColors.primary.withValues(alpha: 0.8),
          ),
        ),
        SizedBox(height: isMobile ? 20 : 28),
        Text(
          'İbadet Rehberim',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: (Theme.of(context).textTheme.headlineMedium?.fontSize ?? 28) * Responsive.headlineScale(context),
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Mobil uygulama yasal sayfaları',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.subtitleColor,
              ),
        ),
        SizedBox(height: isMobile ? 36 : 56),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => context.push('/gizlilik-politikasi'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: isMobile ? 14 : 18),
            ),
            child: const Text('Gizlilik Politikası'),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => context.push('/kullanim-kosullari'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: isMobile ? 14 : 18),
            ),
            child: const Text('Kullanım Koşulları'),
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppAppBar(showBackButton: false),
      body: SafeArea(
        child: Responsive.constrainContent(
          context,
          child: SingleChildScrollView(
            child: Padding(
              padding: padding,
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}
