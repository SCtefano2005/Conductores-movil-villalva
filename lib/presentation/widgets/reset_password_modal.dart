import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordModal extends StatelessWidget {
  const ResetPasswordModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResetPasswordController(),
      child: Consumer<ResetPasswordController>(
        builder: (context, controller, _) {
          // 🟢 Usa SingleChildScrollView + viewInsets
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, // espacio dinámico
            ),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.step == 1
                        ? 'Validar Identidad'
                        : 'Nueva Contraseña',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Paso 1
                  if (controller.step == 1) ...[
                    _buildTextField(
                      label: 'DNI',
                      controller: controller.identificacionController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'N° Licencia',
                      controller: controller.licenciaController,
                    ),
                  ],

                  // Paso 2
                  if (controller.step == 2) ...[
                    _buildTextField(
                      label: 'Nueva Contraseña',
                      controller: controller.passwordController,
                      obscure: true,
                    ),
                  ],

                  const SizedBox(height: 24),

                  if (controller.errorMessage != null)
                    Text(
                      controller.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: controller.isLoading
                        ? null
                        : () {
                            if (controller.step == 1) {
                              controller.validarConductor(context);
                            } else {
                              controller.actualizarPassword(context);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB91C1C),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: controller.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(controller.step == 1 ? 'Validar' : 'Guardar'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscure,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Ingrese $label',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
      ],
    );
  }
}
