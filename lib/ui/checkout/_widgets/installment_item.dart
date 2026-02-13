import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/transaction/models/installment_option.dart';

class InstallmentItem extends StatelessWidget {
  final InstallmentOption option;
  final VoidCallback onClick;

  const InstallmentItem({
    super.key,
    required this.option,
    required this.onClick,
  });

  String _formatCurrency(double value) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);
  }

  @override
  Widget build(BuildContext context) {
    final String monthlyValue = _formatCurrency(option.monthlyAmount);
    final String totalValue = _formatCurrency(option.totalAmount);
    final Color mainColor = Theme.of(context).primaryColor;

    return Column(
      children: [
        InkWell(
          onTap: onClick,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Row(
              children: [
                SizedBox(
                  width: 42,
                  child: Text(
                    "${option.count}x",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                ),

                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        monthlyValue,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        option.interestRate > 0.0
                            ? "Total a pagar: $totalValue (com taxa)"
                            : "Total: $totalValue (sem juros)",
                        style: TextStyle(
                          fontSize: 12,
                          color: option.interestRate > 0.0
                              ? Colors.red.withValues(alpha: 0.8)
                              : Colors.grey,
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
        Padding(
          padding: const EdgeInsets.only(left: 74),
          child: Divider(height: 1, thickness: 0.5, color: Colors.grey[300]),
        ),
      ],
    );
  }
}
