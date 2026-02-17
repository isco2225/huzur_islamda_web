import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_colors.dart';
import '../utils/responsive.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.showBackButton = false,
  });

  final bool showBackButton;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final logoSize = Responsive.appBarLogoSize(context);
    final fontSize = Responsive.appBarTitleFontSize(context);
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              color: AppColors.primary,
              onPressed: () => context.pop(),
            )
          : null,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/icons/app_icon.png',
            height: logoSize,
            width: logoSize,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.mosque, color: AppColors.primary, size: logoSize),
          ),
          SizedBox(width: Responsive.isMobile(context) ? 8 : 12),
          Text(
            'İbadet Rehberim',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
