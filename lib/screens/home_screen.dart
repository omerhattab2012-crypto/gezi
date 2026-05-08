import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/place_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/app_provider.dart';
import '../models/place.dart';
import 'detail_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';
import 'settings_screen.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String secilenFiltre = 'Hepsi';
  String secilenSehir = 'Hepsi';
  String siralama = 'Puan';
  final TextEditingController _aramaController = TextEditingController();

  IconData _turIcon(String tur) {
    switch (tur) {
      case 'Gezi':
        return Icons.landscape_rounded;
      case 'Restoran':
        return Icons.restaurant_rounded;
      case 'Otel':
        return Icons.hotel_rounded;
      default:
        return Icons.place_rounded;
    }
  }

  Color _turRenk(String tur) {
    switch (tur) {
      case 'Gezi':
        return Colors.green;
      case 'Restoran':
        return Colors.orange;
      case 'Otel':
        return const Color(0xFF1A73E8);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final placeProvider = context.watch<PlaceProvider>();
    final authProvider = context.watch<AuthProvider>();
    final app = context.watch<AppProvider>();

    final sehirler = [
      'Hepsi',
      ...{...placeProvider.yerler.map((p) => p.sehir)},
    ];

    var filtrelenmis = placeProvider.yerler.where((yer) {
      final aramaUygun = yer.isim.toLowerCase().contains(
        _aramaController.text.toLowerCase(),
      );
      final filtrUygun = secilenFiltre == 'Hepsi' || yer.tur == secilenFiltre;
      final sehirUygun = secilenSehir == 'Hepsi' || yer.sehir == secilenSehir;
      return aramaUygun && filtrUygun && sehirUygun;
    }).toList();

    if (siralama == 'Puan') {
      filtrelenmis.sort((a, b) => b.puan.compareTo(a.puan));
    } else {
      filtrelenmis.sort((a, b) => b.yorumSayisi.compareTo(a.yorumSayisi));
    }

    final topYerler = [...placeProvider.yerler]
      ..sort((a, b) => b.puan.compareTo(a.puan));
    final onecikarlar = topYerler.take(3).toList();

    final toplamYer = placeProvider.yerler.length;
    final toplamSehir = placeProvider.yerler.map((p) => p.sehir).toSet().length;
    final favoriSayisi = placeProvider.favoriler.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A73E8),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'GeziApp',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings_rounded, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
          IconButton(
            icon: authProvider.girisYapildi
                ? CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white24,
                    child: Text(
                      authProvider.user!.avatarHarf,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const Icon(Icons.account_circle_rounded, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
          ),
        ],
      ),

      body: CustomScrollView(
        slivers: [
          // ── HOŞ GELDİN ──
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A73E8), Color(0xFF0D47A1)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          authProvider.girisYapildi
                              ? '${app.cevir('merhabaKullanici')}, ${authProvider.user!.ad}! 👋'
                              : '${app.cevir('merhabaKullanici')}! 👋',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          app.cevir('bugunNereyi'),
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.explore_rounded,
                    color: Colors.white54,
                    size: 48,
                  ),
                ],
              ),
            ),
          ),

          // ── İSTATİSTİKLER ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  _istatistikKart(
                    '$toplamYer',
                    app.cevir('toplamYer'),
                    Icons.place_rounded,
                    Colors.purple,
                  ),
                  const SizedBox(width: 8),
                  _istatistikKart(
                    '$toplamSehir',
                    app.cevir('sehir'),
                    Icons.location_city_rounded,
                    Colors.teal,
                  ),
                  const SizedBox(width: 8),
                  _istatistikKart(
                    '$favoriSayisi',
                    app.cevir('favori'),
                    Icons.favorite_rounded,
                    Colors.red,
                  ),
                ],
              ),
            ),
          ),

          // ── ARAMA ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _aramaController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: app.cevir('arama'),
                  prefixIcon: const Icon(Icons.search_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                ),
              ),
            ),
          ),

          // ── KATEGORİLER ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: Text(
                app.cevir('kategoriler'),
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const CategoryScreen(kategori: 'Gezi'),
                        ),
                      ),
                      child: Container(
                        height: 80,
                        margin: const EdgeInsets.only(right: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.green, Colors.green.shade300],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.landscape_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              app.cevir('gezi'),
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const CategoryScreen(kategori: 'Restoran'),
                        ),
                      ),
                      child: Container(
                        height: 80,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.orange, Colors.orange.shade300],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.restaurant_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              app.cevir('restoran'),
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const CategoryScreen(kategori: 'Otel'),
                        ),
                      ),
                      child: Container(
                        height: 80,
                        margin: const EdgeInsets.only(left: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF1A73E8),
                              const Color(0xFF1A73E8).withOpacity(0.7),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.hotel_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              app.cevir('otel'),
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── ÖNE ÇIKANLAR ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                app.cevir('onecikanlar'),
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: onecikarlar.length,
                itemBuilder: (context, index) {
                  final Place yer = onecikarlar[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(place: yer),
                      ),
                    ),
                    child: Container(
                      width: 200,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            _turRenk(yer.tur),
                            _turRenk(yer.tur).withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: _turRenk(yer.tur).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            _turIcon(yer.tur),
                            color: Colors.white,
                            size: 32,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                yer.isim,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                yer.sehir,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${yer.puan}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // ── TÜM YERLER + SIRALAMA ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Text(
                    app.cevir('tumYerler'),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    icon: Row(
                      children: [
                        const Icon(
                          Icons.sort_rounded,
                          color: Color(0xFF1A73E8),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          siralama,
                          style: const TextStyle(
                            color: Color(0xFF1A73E8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    onSelected: (deger) => setState(() => siralama = deger),
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        value: 'Puan',
                        child: Text(app.cevir('puan')),
                      ),
                      PopupMenuItem(
                        value: 'Yorum',
                        child: Text(app.cevir('yorum')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ── KATEGORİ FİLTRELERİ ──
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: ['Hepsi', 'Gezi', 'Restoran', 'Otel'].map((filtre) {
                  final secili = secilenFiltre == filtre;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(
                        filtre == 'Hepsi'
                            ? app.cevir('hepsi')
                            : filtre == 'Gezi'
                            ? app.cevir('gezi')
                            : filtre == 'Restoran'
                            ? app.cevir('restoran')
                            : app.cevir('otel'),
                      ),
                      selected: secili,
                      onSelected: (_) => setState(() => secilenFiltre = filtre),
                      selectedColor: const Color(0xFF1A73E8),
                      labelStyle: TextStyle(
                        color: secili ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // ── ŞEHİR FİLTRELERİ ──
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: sehirler.map((sehir) {
                  final secili = secilenSehir == sehir;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(sehir),
                      selected: secili,
                      onSelected: (_) => setState(() => secilenSehir = sehir),
                      selectedColor: const Color(0xFF1A73E8).withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: secili
                            ? const Color(0xFF1A73E8)
                            : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 4)),

          // ── LİSTE ──
          filtrelenmis.isEmpty
              ? SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 40),
                        const Icon(
                          Icons.search_off_rounded,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          app.cevir('sonucBulunamadi'),
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final Place yer = filtrelenmis[index];
                      final favori = placeProvider.favoriMi(yer.id);
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(place: yer),
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: _turRenk(
                              yer.tur,
                            ).withOpacity(0.15),
                            child: Icon(
                              _turIcon(yer.tur),
                              color: _turRenk(yer.tur),
                            ),
                          ),
                          title: Text(
                            yer.isim,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text('${yer.sehir} • ${yer.tur}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${yer.puan}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${yer.yorumSayisi} ${app.cevir('yorumlar')}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: Icon(
                                  favori
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  color: favori ? Colors.red : Colors.grey,
                                ),
                                onPressed: () =>
                                    placeProvider.favoriToggle(yer.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    }, childCount: filtrelenmis.length),
                  ),
                ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _istatistikKart(
    String deger,
    String baslik,
    IconData ikon,
    Color renk,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: renk.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: renk.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(ikon, color: renk, size: 24),
            const SizedBox(height: 4),
            Text(
              deger,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: renk,
              ),
            ),
            Text(
              baslik,
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
