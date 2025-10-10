import 'package:flutter/material.dart';
import '../widgets/BottomNav.dart' show BottomNav;
import 'home_page.dart';
import 'viaje_screen.dart';
import 'chatsi_page.dart';
import 'incidencias_page.dart'; // Importa la clase completa

// Placeholder pages
// class IncidenciasPage extends StatelessWidget {
//  const IncidenciasPage({super.key});
//  @override
//  Widget build(BuildContext context) => const Center(child: Text('Incidencias'));
// }

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Perfil'));
}

// MainPage con BottomNav
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      const MapaPage(),
      const ChatPage(),
      const IncidenciasPage(), // Ahora usa la clase importada del archivo
      const PerfilPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}