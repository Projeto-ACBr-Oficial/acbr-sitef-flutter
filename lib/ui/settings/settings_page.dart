import 'package:fintesthub_flutter/ui/_core/app_colors.dart';
import 'package:fintesthub_flutter/ui/settings/settings_controller.dart';
import 'package:flutter/material.dart';

import '../../core/config/local_settings_keys.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _controller = SettingsController();

  @override
  void initState() {
    super.initState();
    _controller.loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const SizedBox(height: 20),
          _buildTextField(
            label: "Empresa SiTef",
            controller: _controller.empresaController,
            onChanged: (val) =>
                _controller.updateField(SettingsKeys.empresaSitef, val),
          ),
          _buildTextField(
            label: "Endereço IP do SitDemo",
            controller: _controller.enderecoController,
            onChanged: (val) =>
                _controller.updateField(SettingsKeys.enderecoSitef, val),
          ),
          _buildTextField(
            label: "Operador",
            controller: _controller.operadorController,
            onChanged: (val) =>
                _controller.updateField(SettingsKeys.operador, val),
          ),
          _buildTextField(
            label: "CNPJ ou CNPJ",
            controller: _controller.cnpjCpfController,
            onChanged: (val) =>
                _controller.updateField(SettingsKeys.cnpjCpf, val),
          ),
          _buildTextField(
            label: "CNPJ da Automação",
            controller: _controller.cnpjAutomacaoController,
            onChanged: (val) =>
                _controller.updateField(SettingsKeys.cnpjAutomacao, val),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: null,
            child: const Text("Menu administrativo"),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: const UnderlineInputBorder(),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }
}
