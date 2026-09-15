import 'package:chiledex_demo/features/home/presentation/pages/map_page.dart';
import 'package:chiledex_demo/features/home/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:chiledex_demo/features/home/presentation/pages/catalog_page.dart';
import 'package:chiledex_demo/app/navigation/bottom_navbar.dart';
import 'package:chiledex_demo/features/home/presentation/pages/home_page.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  // Permite acceder al estado desde fuera con MainScaffold.of(context)
  static _MainScaffoldState of(BuildContext context) {
    return context.findAncestorStateOfType<_MainScaffoldState>()!;
  }

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;
  String? _catalogCategoria; // categoría a aplicar cuando se abre el catálogo

  // Método público — HomePage lo llama para cambiar de tab y aplicar filtro
  void navegarACatalogo({String? categoria}) {
    setState(() {
      _currentIndex = 1;
      _catalogCategoria = categoria;
    });
  }

  // Construye la lista de páginas con la categoría actual
  List<Widget> get _pages => [
    const HomePage(),
    CatalogPage(categoriaInicial: _catalogCategoria),
    const Placeholder(),
    const MapPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) return;
          setState(() {
            _currentIndex = index;
            // Al cambiar de tab manualmente, limpia el filtro del catálogo
            if (index != 1) _catalogCategoria = null;
          });
        },
      ),
    );
  }
}