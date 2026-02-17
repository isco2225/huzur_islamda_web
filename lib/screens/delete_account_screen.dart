import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/app_app_bar.dart';

/// Data deletion request page for store compliance.
/// Form UI only; backend to be connected later.
class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: backend – send email + reason
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Talebiniz alındı. En kısa sürede işleme alınacaktır.'),
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppAppBar(showBackButton: true),
      body: SingleChildScrollView(
        child: Responsive.constrainContent(
          context,
          child: Padding(
            padding: padding,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Semantics(
                    header: true,
                    child: Text(
                      'Veri Silme Talebi',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 16 : 24),
                  Semantics(
                    container: true,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        'Hesabınızla ilişkili tüm verilerin silinmesini talep etmek için aşağıdaki formu doldurun. '
                        'Talebiniz en geç 30 gün içinde işleme alınacaktır. Sorularınız için gizlilik politikamıza bakabilir veya bizimle iletişime geçebilirsiniz.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.subtitleColor,
                              height: 1.5,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 28 : 36),
                  Text(
                    'E-posta adresi (hesabınızla ilişkili)',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'ornek@email.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'E-posta adresi giriniz';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                        return 'Geçerli bir e-posta adresi giriniz';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isMobile ? 20 : 28),
                  Text(
                    'Neden (isteğe bağlı)',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _reasonController,
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: 'İsterseniz neden veri silme talebinde bulunduğunuzu yazabilirsiniz.',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: isMobile ? 32 : 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onSubmit,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: isMobile ? 14 : 18),
                      ),
                      child: const Text('Talep Gönder'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // TODO: Add url_launcher and use launchUrl(Uri.parse('mailto:destek@example.com?subject=Veri Silme Talebi'))
                      },
                      child: Text(
                        'Bunun yerine e-posta ile göndermek ister misiniz?',
                        style: TextStyle(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
