import 'package:flutter/material.dart';

class PaymentMethodUi {
  final String id;
  final String name;
  final String description;
  final Color color;
  final IconData icon;

  const PaymentMethodUi({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
    required this.icon,
  });
}
