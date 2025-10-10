import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/login_controller.dart';
import '../widgets/login_form_widget.dart';
import '../widgets/background_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginController(),
      child: Scaffold(
        body: Consumer<LoginController>(
          builder: (context, controller, child) {
            return Stack(
              children: [
                const BackgroundWidget(),
                SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // ── Parte superior ───────────────────────────
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 60,
                                  ),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Inicio',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'SISTEMA DE\nMONITOREO DE\nBUSES',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          height: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 40),

                                      // ── Botón Iniciar Sesión (se oculta al abrir modal)
                                      AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 300),
                                        child: controller.activeTab == 'login'
                                            ? const SizedBox.shrink()
                                            : Align(
                                                alignment: Alignment.center,
                                                child: ElevatedButton(
                                                  key: const ValueKey('loginButton'),
                                                  onPressed: () => controller.setActiveTab('login'),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: const Color(0xFFB91C1C),
                                                    foregroundColor: Colors.white,
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                      vertical: 15,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(25),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'INICIAR SESIÓN',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),

                                const Spacer(),

                                // ── Formulario modal ────────────────────────
                                if (controller.activeTab == 'login')
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    color: Colors.white.withOpacity(0.95),
                                    child: const LoginFormWidget(),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
