import 'package:flutter/material.dart';
import 'package:proyecto_moviles/models/communication_item.dart';

// Este widget reutilizable representa una tarjeta individual en la cuadrícula.
// Recibe un objeto de datos (item) y una función (onTap) para manejar el toque.
class CommunicationCard extends StatelessWidget {
  final CommunicationItem item;
  final VoidCallback onTap;

  const CommunicationCard({
    super.key,
    required this.item,
    required this.onTap,
  });


  // Define la apariencia de la tarjeta: elevación (sombra), bordes redondeados,
  // colores basados en el ítem y la disposición vertical (Icono arriba, Texto abajo).
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: item.color.withOpacity(0.2), // Fondo suave del color del ítem
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: item.color, width: 2),
      ),
      child: InkWell(
        onTap: onTap, // Acción al tocar
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono grande
            Icon(
              item.icon,
              size: 60,
              color: item.color,
            ),
            const SizedBox(height: 12),
            // Texto descriptivo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: item.color.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}