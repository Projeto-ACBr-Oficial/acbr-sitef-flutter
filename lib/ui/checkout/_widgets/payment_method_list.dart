import 'package:flutter/material.dart';

import '../models/payment_method_ui.dart';
import 'payment_method_item.dart';

class PaymentMethodList extends StatelessWidget {
  final List<PaymentMethodUi> methods;
  final ValueChanged<String> onMethodSelected;

  const PaymentMethodList({
    super.key,
    required this.methods,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            "Escolha o método de pagamento:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(thickness: 1, color: Color(0xFFE0E0E0)),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: methods.length,
            itemBuilder: (context, index) {
              final method = methods[index];
              return PaymentMethodItem(
                method: method,
                onClick: () => onMethodSelected(method.id),
              );
            },
          ),
        ),
      ],
    );
  }
}
