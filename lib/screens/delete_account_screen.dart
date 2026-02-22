import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  bool _isLoading = false;

  // EmailJS ayarları - https://www.emailjs.com adresinden alacaksın
  // Ücretsiz hesap açıp Public Key ve Service ID'yi buraya ekle
  static const String _emailjsPublicKey =
      'NYh4ChOPW2-Eo3i8M'; // EmailJS Public Key
  static const String _emailjsServiceId =
      'service_9sgvp6i'; // EmailJS Service ID
  static const String _emailjsTemplateId =
      'template_7thm9mu'; // EmailJS Template ID
  static const String _recipientEmail = 'ibadetrehberim@gmail.com';

  @override
  void dispose() {
    _emailController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _sendEmail() async {
    try {
      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_id': _emailjsServiceId,
          'template_id': _emailjsTemplateId,
          'user_id': _emailjsPublicKey,
          'template_params': {
            'user_email': _emailController.text.trim(),
            'reason': _reasonController.text.trim().isNotEmpty
                ? _reasonController.text.trim()
                : 'Belirtilmedi',
            'to_email': _recipientEmail,
            'subject': 'Veri Silme Talebi - İbadet Rehberim',
            'message':
                'Kullanıcı veri silme talebinde bulunmuştur.\n\n'
                'E-posta: ${_emailController.text.trim()}\n'
                'Neden: ${_reasonController.text.trim().isNotEmpty ? _reasonController.text.trim() : "Belirtilmedi"}',
          },
        }),
      );

      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Talebiniz alındı. En kısa sürede işleme alınacaktır.',
              ),
              backgroundColor: Colors.green,
            ),
          );
          // Formu temizle
          _emailController.clear();
          _reasonController.clear();
        }
      } else {
        throw Exception('Email gönderilemedi: ${response.statusCode}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bir hata oluştu: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      await _sendEmail();
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
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
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
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value.trim())) {
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
                      hintText:
                          'İsterseniz neden veri silme talebinde bulunduğunuzu yazabilirsiniz.',
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
                      onPressed: _isLoading ? null : _onSubmit,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: isMobile ? 14 : 18,
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text('Talep Gönder'),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
