import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_colors.dart';
import '../utils/responsive.dart';

/// Marketing landing page footer: legal links, copyright, social placeholders.
class LandingFooter extends StatelessWidget {
  const LandingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padH = Responsive.sectionHorizontalPadding(context);
    final padV = isMobile ? 32.0 : (Responsive.isWideDesktop(context) ? 56.0 : 48.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
      color: AppColors.primary.withValues(alpha: 0.08),
      child: Responsive.constrainLandingContent(
        context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: isMobile ? 16 : 24,
              runSpacing: 12,
              children: [
                _FooterLink(
                  label: 'Gizlilik Politikası',
                  onTap: () => context.push('/gizlilik-politikasi'),
                ),
                _FooterLink(
                  label: 'Kullanım Koşulları',
                  onTap: () => context.push('/kullanim-kosullari'),
                ),
                _FooterLink(
                  label: 'Veri Silme Talebi',
                  onTap: () => context.push('/delete-account'),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 20 : 28),
            Text(
              '© ${DateTime.now().year} İbadet Rehberim. Tüm hakları saklıdır.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.subtitleColor,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isMobile ? 12 : 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.facebook),
                  color: AppColors.primary,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.camera_alt),
                  color: AppColors.primary,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.alternate_email),
                  color: AppColors.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
