import 'dart:io';

import 'package:flutter/material.dart';

class AdaptativeInputText extends StatelessWidget {
  const AdaptativeInputText({
    super.key,
    required this.label,
    this.onSubmit,
    this.type,
    required this.controller,
  });
  final String label;
  final Function()? onSubmit;
  final TextInputType? type;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      controller: controller,
      keyboardType: type,
      onSubmitted: (_) => onSubmit!(),
    );
  }
}
