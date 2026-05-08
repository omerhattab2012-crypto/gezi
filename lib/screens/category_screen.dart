import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/place_provider.dart';
import '../providers/app_provider.dart';
import '../models/place.dart';
import 'detail_screen.dart';

class CategoryScreen extends StatefulWidget {
  final String kategori;
  const CategoryScreen({super.key, required this.kategori});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String _siralama = 'Puan';
  String _secilenSehir = 'Hepsi';

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

  @override
  Widget build(BuildContext context) {
    final placeProvider = context.watch<PlaceProvider>();
    final app = context.watch<AppProvider>();

    var yerler = placeProvider.yerler
        .where((p) => p.tur == widget.kategori)
        .toList();

    if (_secilenSehir != 'Hepsi') {
      yerler = yerler.where((p) => p.sehir == _secilenSehir).toList();
    }

    if (_siralama == 'Puan') {
      yerler.sort((a, b) => b.puan.compareTo(a.puan));
    } else {
      yerler.sort((a, b) => b.yorumSayisi.compareTo(a.yorumSayisi));
    }

    final sehirler = [
      'Hepsi',
      ...{
        ...placeProvider.yerler
            .where((p) => p.tur == widget.kategori)
            .map((p) => p.sehir),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _turRenk(widget.kategori),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.kategori == 'Gezi'
              ? app.cevir('gezi')
              : widget.kategori == 'Restoran'
              ? app.cevir('restoran')
              : app.cevir('otel'),
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort_rounded, color: Colors.white),
            onSelected: (deger) => setState(() => _siralama = deger),
            itemBuilder: (_) => [
              PopupMenuItem(value: 'Puan', child: Text(app.cevir('puan'))),
              PopupMenuItem(value: 'Yorum', child: Text(app.cevir('yorum'))),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: sehirler.map((sehir) {
                final secili = _secilenSehir == sehir;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(sehir == 'Hepsi' ? app.cevir('hepsi') : sehir),
                    selected: secili,
                    onSelected: (_) => setState(() => _secilenSehir = sehir),
                    selectedColor: _turRenk(widget.kategori),
                    labelStyle: TextStyle(
                      color: secili ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Text(
                  '${yerler.length} ${app.cevir('toplamYer')}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                const Spacer(),
                Text(
                  '$_siralama',
                  style: TextStyle(
                    color: _turRenk(widget.kategori),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: yerler.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _turIcon(widget.kategori),
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
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: yerler.length,
                    itemBuilder: (context, index) {
                      final Place yer = yerler[index];
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
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
