import 'package:flutter/material.dart';

class IncidenciasPage extends StatelessWidget {
  const IncidenciasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF4EB),
      body: Stack(
        children: [
          // Fondo del bus como imagen que ahora ocupará todo el espacio disponible
          Positioned.fill( // <-- ¡Esta es la clave!
            child: Opacity(
              opacity: 0.8, // Ajusta la opacidad según prefieras
              child: Image.asset(
                'assets/porqmiras.jpeg', // Ruta de tu imagen de fondo
                  width: 150, // Reduce el tamaño a la mitad
                 height: 150, // Reduce el tamaño a la mitad
                // Esto asegura que la imagen cubra todo el espacio sin distorsionarse
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 50),
                // Título y contenedor
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Text(
                    'Reportar incidencia',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5E4B8A),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Tipo de incidencia
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tipo de incidencia',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: null,
                      hint: const Text('Descripción'),
                      items: const [], // Puedes agregar opciones aquí
                      onChanged: (String? newValue) {},
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Sección de imágenes
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Imágenes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Imagen subida (ejemplo)
                    _buildImagePlaceholder(),
                    const SizedBox(width: 16),
                    _buildAddImageButton(),
                  ],
                ),
                const Spacer(),
                // Botón de enviar
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF673AB7),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Enviar incidencia',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.photo_library, color: Colors.grey),
    );
  }

  Widget _buildAddImageButton() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD8D8D8), width: 2),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle_outline, color: Color(0xFF9663A4)),
          SizedBox(height: 4),
          Text('Añadir foto',
              style: TextStyle(
                color: Color(0xFF9663A4),
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}