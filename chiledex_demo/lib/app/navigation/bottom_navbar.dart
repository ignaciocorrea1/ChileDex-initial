import 'package:chiledex_demo/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  // Variables para el estado del BottomNavbar
  final int currentIndex;
  final Function(int) onTap;

  // Inicializador del constructor
  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  // Creacion del widget
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex, // Indice de la vista
      
      onTap: onTap, // Funcion que se ejecuta al tocar un item
      
      type: BottomNavigationBarType.fixed, // Tipo de barra
      
      backgroundColor: AppTheme.cardWhite, // Color de fondo
      
      selectedItemColor: AppTheme.accentOrange, // Color del item seleccionado
      
      unselectedItemColor: AppTheme.textGray, // Color de los items no seleccionados
      
      selectedFontSize: 11, // Tamaño de fuente del item seleccionado
      
      unselectedFontSize: 11, // Tamaño de fuente de los items no seleccion
      
      items: [ // Opciones del Navbar
        // Inicio
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined), // Icono del item
          
          activeIcon: Icon(Icons.home), // Icono del item seleccionado
          
          label: 'Inicio', // Texto del item
        ),
        
        // Catalogo
        const BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined), // Icono del item
          
          activeIcon: Icon(Icons.explore), // Icono del item seleccionado
          
          label: 'Catálogo', // Texto del item
        ),
        
        // Cámara
        BottomNavigationBarItem(
          icon: Container( // Icono customizado
            width: 52,
            
            height: 52,
            
            decoration: BoxDecoration( // Fondo naranjo y dentro el icono de la camara
              
              color: AppTheme.accentOrange,
              
              shape: BoxShape.circle,
            ),
            
            child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 28),
          ),
          label: ''
        ),

        // Mapa 
        const BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined), // Icono del item
          
          activeIcon: Icon(Icons.map), // Icono del item seleccionado
          
          label: 'Mapa', // Texto del item
        ),
        
        // Perfil
        const BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border_outlined), // Icono del item
          
          activeIcon: Icon(Icons.bookmark), // Icono del item seleccionado
          
          label: 'Perfil', // Texto del item
        ),
      ]
    );
  }
}