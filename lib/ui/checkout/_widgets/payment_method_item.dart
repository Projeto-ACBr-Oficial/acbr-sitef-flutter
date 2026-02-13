import 'package:flutter/material.dart';

import '../models/payment_method_ui.dart';

class PaymentMethodItem extends StatelessWidget {
  final PaymentMethodUi method;
  final VoidCallback onClick;

  const PaymentMethodItem({
    super.key,
    required this.method,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onClick,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Row(
              children: [
                Icon(
                  method.icon,
                  size: 32,
                  color: method.color.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        method.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        method.description,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              ],
            ),
          ),
        ),

        Divider(indent: 64, height: 1, thickness: 0.5, color: Colors.grey[300]),
      ],
    );
  }
}
