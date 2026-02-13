import 'package:flutter/material.dart';

import '../../../domain/transaction/models/installment_option.dart';
import 'installment_item.dart';

class InstallmentList extends StatelessWidget {
  final List<InstallmentOption> installments;
  final ValueChanged<InstallmentOption> onInstallmentSelected;

  const InstallmentList({
    super.key,
    required this.installments,
    required this.onInstallmentSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            "Selecione o número de parcelas:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Divider(thickness: 1, color: Colors.grey[300]),
        ),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: installments.length,
            itemBuilder: (context, index) {
              final option = installments[index];
              return InstallmentItem(
                option: option,
                onClick: () => onInstallmentSelected(option),
              );
            },
          ),
        ),
      ],
    );
  }
}
