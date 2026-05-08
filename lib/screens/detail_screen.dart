import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/place.dart';
import '../providers/place_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/app_provider.dart';

class DetailScreen extends StatefulWidget {
  final Place place;
  const DetailScreen({super.key, required this.place});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _yorumController = TextEditingController();

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

    final place = placeProvider.yerler.firstWhere(
      (p) => p.id == widget.place.id,
    );
    final favori = placeProvider.favoriMi(place.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: const Color(0xFF1A73E8),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: Icon(
                  favori
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: Colors.white,
                ),
                onPressed: () => placeProvider.favoriToggle(place.id),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                place.isim,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _turRenk(place.tur),
                      _turRenk(place.tur).withOpacity(0.6),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    place.tur == 'Gezi'
                        ? Icons.landscape_rounded
                        : place.tur == 'Restoran'
                        ? Icons.restaurant_rounded
                        : Icons.hotel_rounded,
                    size: 80,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: Colors.grey[600],
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${place.sehir} • ${place.tur}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Puan kartı
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 28,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${place.puan}',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${place.yorumSayisi} ${app.cevir('yorumlar')})',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    app.cevir('hakkinda'),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    place.aciklama,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    app.cevir('ozellikler'),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: place.ozellikler.map((ozellik) {
                      return Chip(
                        label: Text(ozellik),
                        backgroundColor: _turRenk(place.tur).withOpacity(0.1),
                        labelStyle: TextStyle(color: _turRenk(place.tur)),
                        side: BorderSide(
                          color: _turRenk(place.tur).withOpacity(0.3),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Yorumlar
                  Text(
                    '${app.cevir('yorumlar')} (${place.yorumlar.length})',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (authProvider.girisYapildi) ...[
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _yorumController,
                            decoration: InputDecoration(
                              hintText: app.cevir('yorumYaz'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xFF1A73E8),
                            foregroundColor: Colors.white,
                          ),
                          icon: const Icon(Icons.send_rounded),
                          onPressed: () {
                            if (_yorumController.text.trim().isNotEmpty) {
                              placeProvider.yorumEkle(
                                place.id,
                                authProvider.user!.ad,
                                _yorumController.text.trim(),
                              );
                              _yorumController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ] else ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_rounded, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            app.cevir('yorumEkle'),
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (place.yorumlar.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          app.cevir('henuzYorum'),
                          style: TextStyle(color: Colors.grey[500]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  else
                    ...place.yorumlar.map((yorum) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: const Color(0xFF1A73E8),
                                  child: Text(
                                    yorum['kullanici']![0].toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  yorum['kullanici']!,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  yorum['tarih']!,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              yorum['yorum']!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    }),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.map_rounded),
                      label: Text(app.cevir('haritadaGoster')),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A73E8),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
