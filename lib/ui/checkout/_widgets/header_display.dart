import 'package:fintesthub_flutter/ui/_core/app_colors.dart';
import 'package:flutter/material.dart';

class HeaderDisplay extends StatelessWidget {
  final String value;

  const HeaderDisplay({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final Color mainColor = AppColors.primary;

    return Container(
      width: double.infinity,
      height: 100,
      color: mainColor.withValues(alpha: 0.3),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Valor a pagar",
            style: TextStyle(fontSize: 16, height: 1.0, color: Colors.black),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 36,
              color: mainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
