import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

  // Configuracion global del diseño de la app
class AppTheme {
  // Paleta de colores
  static const Color primaryGreen = Color(0xFF2D5A27); // Verde oscuro
  static const Color accentOrange = Color(0xFFC1502A); // Naranja
  static const Color backgroundCream = Color(0xFFF5F0E8); // Crema
  static const Color cardWhite = Color(0xFFFFFFFF); // Blanco
  static const Color textDark = Color(0xFF1A1A1A); // Negro
  static const Color textGray = Color(0xFF6B6B6B); // Gris
  static const Color lightGray = Color(0xFFE0E0E0); // Gris
  static const Color successGreen = Color(0xFF4CAF50); // Verde claro
  
  // Getter para acceder a la configuración
  static ThemeData get theme => ThemeData(
    useMaterial3: true, //Material design 3
    
    scaffoldBackgroundColor: backgroundCream, // Color del fondo de cada pantalla
    
    colorScheme: ColorScheme.fromSeed( // Paleta para los componentes
      seedColor: primaryGreen, // Color para generar la paleta
      primary: primaryGreen, // Color principal
      secondary: accentOrange, // Color secundario
      surface: cardWhite, // Color de superficie 
    ),
    
    textTheme: GoogleFonts.outfitTextTheme(), // Fuente de texto
    
    appBarTheme: const AppBarTheme( // Barra superior
      backgroundColor: backgroundCream, // Color de fondo
      foregroundColor: textDark, // Color de iconos y titulo
      elevation: 0, // Sin sombra
      centerTitle: true, // Titulo siempre centrado
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData( // Botones elevados
      style: ElevatedButton.styleFrom(
        backgroundColor: accentOrange, // Color de fondo
        foregroundColor: Colors.white, // Color del texto
        minimumSize: const Size(double.infinity, 52), // Tamaño minimo del boton, 52px
        shape: RoundedRectangleBorder( // Forma del boton
          borderRadius: BorderRadius.circular(14), // Bordes redondeados
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationThemeData(
      filled: true, // Campo con fondo
      fillColor: cardWhite, // Color de fondo del input
      
      // Borde por defecto
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),

      // Borde cuando el input esta enfocado
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),

      // Borde cuando el usuario está escribiendo
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryGreen, width: 2),
      ),
    ),
  );
}