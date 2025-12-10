import 'package:flutter/material.dart';

// Actúa como un contenedor de propiedades (ID, texto, icono, color) para
// pasar información de manera ordenada por toda la aplicación.
class CommunicationItem {
  final String id;
  final String text;
  final IconData icon;
  final Color color;

  CommunicationItem({
    required this.id,
    required this.text,
    required this.icon,
    required this.color,
  });
}