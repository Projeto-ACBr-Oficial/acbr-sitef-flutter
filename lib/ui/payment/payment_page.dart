import 'package:fintesthub_flutter/ui/payment/payment_controller.dart';
import 'package:flutter/material.dart';

import '../checkout/checkout_screen.dart';
import '_widgets/display_field.dart';
import '_widgets/keypad_button.dart';
import '_widgets/numeric_keypad.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _controller = PaymentController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleStateChange);
  }

  void _handleStateChange() {
    if (_controller.errorMessage != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Alerta"),
          content: Text(_controller.errorMessage!),
          actions: [
            TextButton(
              onPressed: () {
                _controller.clearError();
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double maxKeypadWidth = 400.0;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxKeypadWidth),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DisplayField(value: _controller.formattedValue),
                const SizedBox(height: 20),
                NumericKeypad(
                  onNumberClick: _controller.appendNumber,
                  onDeleteClick: _controller.deleteLastDigit,
                  onClearClick: _controller.clearValue,
                ),
                const SizedBox(height: 12),
                ActionButton(
                  label: "Pagar",
                  color: const Color(0xFF4CAF50),
                  onClick: () {
                    if (_controller.onPaymentAction()) {
                      final int amount = _controller.valueInCents;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CheckoutScreen(amountInCents: amount),
                        ),
                      );

                      _controller.clearValue();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
