import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/place_provider.dart';
import '../providers/app_provider.dart';
import '../models/place.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _aramaController = TextEditingController();
  String _aramaMetni = '';

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

    final sonuclar = _aramaMetni.isEmpty
        ? <Place>[]
        : placeProvider.yerler
              .where(
                (yer) =>
                    yer.isim.toLowerCase().contains(
                      _aramaMetni.toLowerCase(),
                    ) ||
                    yer.sehir.toLowerCase().contains(_aramaMetni.toLowerCase()),
              )
              .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A73E8),
        iconTheme: const IconThemeData(color: Colors.white),
        title: TextField(
          controller: _aramaController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: app.cevir('arama'),
            hintStyle: const TextStyle(color: Colors.white60),
            border: InputBorder.none,
          ),
          onChanged: (deger) => setState(() => _aramaMetni = deger),
        ),
        actions: [
          if (_aramaMetni.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_rounded, color: Colors.white),
              onPressed: () {
                _aramaController.clear();
                setState(() => _aramaMetni = '');
              },
            ),
        ],
      ),
      body: _aramaMetni.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.search_rounded,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Aramak istediğinizi yazın',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : sonuclar.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.search_off_rounded,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    app.cevir('sonucBulunamadi'),
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: sonuclar.length,
              itemBuilder: (context, index) {
                final Place yer = sonuclar[index];
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
                      backgroundColor: _turRenk(yer.tur).withOpacity(0.15),
                      child: Icon(_turIcon(yer.tur), color: _turRenk(yer.tur)),
                    ),
                    title: Text(
                      yer.isim,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('${yer.sehir} • ${yer.tur}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${yer.puan}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
