import 'package:flutter/material.dart';
import 'package:chiledex_demo/features/home/presentation/pages/catalog_page.dart';
import 'package:chiledex_demo/features/home/presentation/pages/profile_page.dart';
import 'package:chiledex_demo/features/home/presentation/pages/map_page.dart';
import 'package:chiledex_demo/app/navigation/bottom_navbar.dart';
import 'package:chiledex_demo/features/home/presentation/pages/home_page.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  // Lista de páginas — índice 2 es placeholder porque la cámara es modal
  final List<Widget> _pages = [
    const HomePage(), // Inicio
    const CatalogPage(), // Catálogo
    const SizedBox.shrink(), // Cámara
    const MapPage(), // Mapa
    const ProfilePage(), // Perfil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            // Modal de la cámara
            return;
          }
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}