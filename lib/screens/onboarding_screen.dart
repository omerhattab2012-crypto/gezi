import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _mevcutSayfa = 0;
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> _sayfalar = [
    {
      'ikon': Icons.explore_rounded,
      'baslik': 'Türkiye\'yi Keşfet',
      'aciklama':
          'Türkiye\'nin en güzel gezi yerlerini, restoranlarını ve otellerini tek uygulamada keşfet.',
      'renk': const Color(0xFF1A73E8),
    },
    {
      'ikon': Icons.restaurant_rounded,
      'baslik': 'En İyi Restoranlar',
      'aciklama':
          'Bulunduğun şehrin en lezzetli restoranlarını bul, puanlarını ve yorumlarını gör.',
      'renk': Colors.orange,
    },
    {
      'ikon': Icons.favorite_rounded,
      'baslik': 'Favorilerine Ekle',
      'aciklama':
          'Beğendiğin yerleri favorilerine ekle, istediğin zaman hızlıca ulaş.',
      'renk': Colors.red,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _giriseSayfasinaGit() {
    // Onboarding tamamlandı olarak işaretle
    context.read<AppProvider>().onboardingTamamla();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _giriseSayfasinaGit,
                child: const Text('Atla', style: TextStyle(color: Colors.grey)),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _sayfalar.length,
                onPageChanged: (index) => setState(() => _mevcutSayfa = index),
                itemBuilder: (context, index) {
                  final sayfa = _sayfalar[index];
                  return Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: (sayfa['renk'] as Color).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            sayfa['ikon'] as IconData,
                            size: 72,
                            color: sayfa['renk'] as Color,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          sayfa['baslik'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          sayfa['aciklama'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey[600],
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_sayfalar.length, (index) {
                final secili = _mevcutSayfa == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: secili ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: secili ? const Color(0xFF1A73E8) : Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_mevcutSayfa < _sayfalar.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _giriseSayfasinaGit();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A73E8),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    _mevcutSayfa < _sayfalar.length - 1 ? 'İleri' : 'Başla',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
