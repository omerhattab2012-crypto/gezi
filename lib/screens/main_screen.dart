import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _secilenIndex = 0;

  final List<Widget> _ekranlar = [
    const HomeScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();

    return Scaffold(
      body: _ekranlar[_secilenIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _secilenIndex,
        onDestinationSelected: (index) => setState(() => _secilenIndex = index),
        indicatorColor: const Color(0xFF1A73E8).withOpacity(0.15),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(
              Icons.home_rounded,
              color: Color(0xFF1A73E8),
            ),
            label: app.cevir('anaSayfa'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite_outline_rounded),
            selectedIcon: const Icon(
              Icons.favorite_rounded,
              color: Color(0xFF1A73E8),
            ),
            label: app.cevir('favoriler'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline_rounded),
            selectedIcon: const Icon(
              Icons.person_rounded,
              color: Color(0xFF1A73E8),
            ),
            label: app.cevir('profil'),
          ),
        ],
      ),
    );
  }
}
