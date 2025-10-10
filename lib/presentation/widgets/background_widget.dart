import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1F2937), // gray-800
            Color(0xFF374151), // gray-700
            Color(0xFF1F2937), // gray-800
          ],
        ),
      ),
      child: Stack(
        children: [
          // Aquí puedes agregar tu imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/bus.jpg',
              fit: BoxFit.cover,
            ),
          ),
          
          // Overlay con gradiente
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}