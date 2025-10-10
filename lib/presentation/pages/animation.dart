import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';

class HomeAnimation extends StatelessWidget {
  const HomeAnimation({super.key});

  Future<bool> checkModel() async {
    // Simulamos la carga del modelo
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: checkModel(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !(snapshot.data ?? false)) {
            return const Center(
              child: Text(
                'Error: no se pudo cargar el modelo',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          } else {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: O3D(
                src: 'assets/busmodel.glb',
              ),
            );
          }
        },
      ),
    );
  }
}
