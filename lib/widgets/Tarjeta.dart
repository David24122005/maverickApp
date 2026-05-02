import 'package:flutter/material.dart';

class Tarjeta extends StatelessWidget {
  final String titulo;
  final String mensaje;
  final VoidCallback onCerrar; // Función para ocultar el error

  const Tarjeta({
    super.key,
    required this.titulo,
    required this.mensaje,
    required this.onCerrar,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Stack(
          alignment: Alignment
              .topRight, // Alinea los hijos del Stack arriba a la derecha
          children: [
            // --- CAPA 1: La Tarjeta con el contenido ---
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  40,
                  24,
                  24,
                ), // Más espacio arriba para la X
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.orange,
                      size: 50,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      mensaje,
                      style: const TextStyle(color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // --- CAPA 2: El botón de cerrar (la X) ---
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: onCerrar,
                splashRadius:
                    20, // Hace que el efecto de clic sea pequeño y sutil
              ),
            ),
          ],
        ),
      ),
    );
  }
}
