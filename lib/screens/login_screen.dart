import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/app_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _sifreController = TextEditingController();
  bool _yukleniyor = false;
  bool _sifreGizli = true;
  bool _kayitModu = false; // Giriş mi kayıt mı?

  Future<void> _girisYap() async {
    if (_emailController.text.trim().isEmpty ||
        _sifreController.text.trim().isEmpty) {
      _snackbar('Lütfen tüm alanları doldurun', Colors.orange);
      return;
    }

    setState(() => _yukleniyor = true);
    final auth = context.read<AuthProvider>();
    final basarili = await auth.girisYap(
      _emailController.text.trim(),
      _sifreController.text.trim(),
    );
    setState(() => _yukleniyor = false);

    if (basarili && mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (mounted) {
      _snackbar('Şifre en az 6 karakter olmalıdır!', Colors.red);
    }
  }

  void _snackbar(String mesaj, Color renk) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mesaj), backgroundColor: renk));
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A73E8), Color(0xFF0D47A1)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 48),

                // Logo
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.explore_rounded,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'GeziApp',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _kayitModu ? 'Yeni hesap oluştur' : 'Hesabına giriş yap',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 32),

                // Form kartı
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _kayitModu ? 'Kayıt Ol' : 'Hoş Geldiniz',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _kayitModu
                            ? 'Bilgilerinizi girin'
                            : 'Devam etmek için giriş yapın',
                        style: TextStyle(color: Colors.grey[500]),
                      ),

                      const SizedBox(height: 24),

                      // E-posta
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'E-posta',
                          prefixIcon: const Icon(
                            Icons.email_rounded,
                            color: Color(0xFF1A73E8),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF1A73E8),
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Şifre
                      TextField(
                        controller: _sifreController,
                        obscureText: _sifreGizli,
                        decoration: InputDecoration(
                          labelText: 'Şifre',
                          prefixIcon: const Icon(
                            Icons.lock_rounded,
                            color: Color(0xFF1A73E8),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _sifreGizli
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                              color: Colors.grey,
                            ),
                            onPressed: () =>
                                setState(() => _sifreGizli = !_sifreGizli),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF1A73E8),
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Giriş / Kayıt butonu
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _yukleniyor ? null : _girisYap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A73E8),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _yukleniyor
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  _kayitModu
                                      ? 'Kayıt Ol'
                                      : app.cevir('girisYap'),
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Giriş / Kayıt geçiş
                      Center(
                        child: TextButton(
                          onPressed: () =>
                              setState(() => _kayitModu = !_kayitModu),
                          child: Text(
                            _kayitModu
                                ? 'Zaten hesabın var mı? Giriş Yap'
                                : 'Hesabın yok mu? Kayıt Ol',
                            style: const TextStyle(color: Color(0xFF1A73E8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  'Test için: herhangi bir email\nve 6+ karakter şifre girin',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.white60,
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
