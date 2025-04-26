import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const TextInput({required this.label, required this.controller, super.key});

  String? _defaultValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: label,
            floatingLabelStyle:
                const TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
        controller: controller,
        validator: _defaultValidate,
      ),
    );
  }
}
