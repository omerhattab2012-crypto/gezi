import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/app_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final app = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A73E8),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          app.cevir('ayarlar'),
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          _baslik(app.cevir('genel')),

          // Karanlık mod — toggle basınca tema değişir
          SwitchListTile(
            secondary: const Icon(
              Icons.dark_mode_rounded,
              color: Color(0xFF1A73E8),
            ),
            title: Text(app.cevir('karanlikMod')),
            subtitle: Text(app.cevir('koyuTemaKullan')),
            value: app.karanlikMod,
            activeColor: const Color(0xFF1A73E8),
            onChanged: (deger) => app.karanlikModToggle(deger),
          ),

          // Dil — seçince tüm uygulama o dile geçer
          ListTile(
            leading: const Icon(
              Icons.language_rounded,
              color: Color(0xFF1A73E8),
            ),
            title: Text(app.cevir('dil')),
            subtitle: Text(app.dil),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => _dilSecDialog(context, app),
          ),

          const Divider(),
          _baslik(app.cevir('hesap')),

          if (auth.girisYapildi) ...[
            ListTile(
              leading: const Icon(
                Icons.person_rounded,
                color: Color(0xFF1A73E8),
              ),
              title: Text(app.cevir('hesapBilgileri')),
              subtitle: Text(auth.user!.email),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: Colors.red),
              title: Text(
                app.cevir('cikisYap'),
                style: const TextStyle(color: Colors.red),
              ),
              onTap: () {
                auth.cikisYap();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ] else
            ListTile(
              leading: const Icon(
                Icons.login_rounded,
                color: Color(0xFF1A73E8),
              ),
              title: Text(app.cevir('girisYap')),
              onTap: () => Navigator.pushReplacementNamed(context, '/login'),
            ),

          const Divider(),
          _baslik(app.cevir('hakkinda')),

          ListTile(
            leading: const Icon(Icons.info_rounded, color: Color(0xFF1A73E8)),
            title: Text(app.cevir('uygulamaHakkinda')),
            subtitle: const Text('GeziApp v1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.star_rounded, color: Color(0xFF1A73E8)),
            title: Text(app.cevir('uygulamamiPuanla')),
          ),
        ],
      ),
    );
  }

  Widget _baslik(String baslik) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        baslik,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1A73E8),
        ),
      ),
    );
  }

  void _dilSecDialog(BuildContext context, AppProvider app) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(app.cevir('dilSec')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['Türkçe', 'English', 'Deutsch'].map((dil) {
            return RadioListTile<String>(
              title: Text(dil),
              value: dil,
              groupValue: app.dil,
              activeColor: const Color(0xFF1A73E8),
              onChanged: (deger) {
                app.dilDegistir(deger!);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
