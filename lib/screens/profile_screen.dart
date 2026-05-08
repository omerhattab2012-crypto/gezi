import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/place_provider.dart';
import '../providers/app_provider.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _adController = TextEditingController();
  bool _duzenliyor = false;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final placeProvider = context.watch<PlaceProvider>();
    final app = context.watch<AppProvider>();

    if (!auth.girisYapildi) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A73E8),
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            app.cevir('profil'),
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.account_circle_rounded,
                size: 80,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text('Giriş yapılmadı', style: GoogleFonts.poppins(fontSize: 18)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A73E8),
                  foregroundColor: Colors.white,
                ),
                child: Text(app.cevir('girisYap')),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A73E8),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          app.cevir('profil'),
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Avatar
            CircleAvatar(
              radius: 48,
              backgroundColor: const Color(0xFF1A73E8),
              child: Text(
                auth.user!.avatarHarf,
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Ad düzenleme
            _duzenliyor
                ? Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _adController,
                          autofocus: true,
                          decoration: InputDecoration(
                            labelText: 'Adınız',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.check_rounded,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          if (_adController.text.trim().isNotEmpty) {
                            auth.adGuncelle(_adController.text.trim());
                          }
                          setState(() => _duzenliyor = false);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.red,
                        ),
                        onPressed: () => setState(() => _duzenliyor = false),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        auth.user!.ad,
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit_rounded,
                          size: 18,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _adController.text = auth.user!.ad;
                          setState(() => _duzenliyor = true);
                        },
                      ),
                    ],
                  ),

            Text(auth.user!.email, style: TextStyle(color: Colors.grey[600])),

            const SizedBox(height: 24),

            // İstatistik kartları
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.red.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.favorite_rounded,
                          color: Colors.red,
                          size: 28,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${placeProvider.favoriler.length}',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          app.cevir('favoriler'),
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.blue.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.comment_rounded,
                          color: Color(0xFF1A73E8),
                          size: 28,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${placeProvider.yerler.fold(0, (toplam, yer) => toplam + yer.yorumlar.length)}',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1A73E8),
                          ),
                        ),
                        Text(
                          app.cevir('yorumlar'),
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Ayarlar butonu
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/settings'),
                icon: const Icon(
                  Icons.settings_rounded,
                  color: Color(0xFF1A73E8),
                ),
                label: Text(
                  app.cevir('ayarlar'),
                  style: const TextStyle(color: Color(0xFF1A73E8)),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF1A73E8)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Çıkış butonu
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  auth.cikisYap();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                icon: const Icon(Icons.logout_rounded, color: Colors.red),
                label: Text(
                  app.cevir('cikisYap'),
                  style: const TextStyle(color: Colors.red),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
