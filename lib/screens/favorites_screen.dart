import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/place_provider.dart';
import '../providers/app_provider.dart';
import '../models/place.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
    final favoriler = placeProvider.favoriler;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A73E8),
        title: Text(
          app.cevir('favoriler'),
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: favoriler.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.favorite_border_rounded,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    app.cevir('favoriEklenmedi'),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    app.cevir('kalpIkonu'),
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favoriler.length,
              itemBuilder: (context, index) {
                final Place yer = favoriler[index];
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
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                          ),
                          onPressed: () => placeProvider.favoriToggle(yer.id),
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
