import 'package:fintesthub_flutter/data/msitef/msitef_payment_processor.dart';
import 'package:fintesthub_flutter/ui/checkout/_widgets/header_display.dart';
import 'package:fintesthub_flutter/ui/checkout/_widgets/installment_list.dart';
import 'package:fintesthub_flutter/ui/checkout/_widgets/payment_method_list.dart';
import 'package:flutter/material.dart';

import '../_core/app_colors.dart';
import 'checkout_controller.dart';
import 'models/transaction_result_ui.dart';

class CheckoutScreen extends StatefulWidget {
  final int amountInCents;

  const CheckoutScreen({super.key, required this.amountInCents});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late final CheckoutController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CheckoutController(
      amountInCents: widget.amountInCents,
      paymentProcessor: MSitefPaymentProcessor(),
    );

    _controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    if (_controller.transactionResult != null) {
      final result = _controller.transactionResult!;
      _showResultDialog(result);
    }
  }

  void _showResultDialog(TransactionResultUi result) {
    final result = _controller.transactionResult!;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text(result.title),
        content: Text(result.message),
        actions: [
          TextButton(
            onPressed: () {
              _controller.resetTransactionResult();
              Navigator.pop(dialogContext);

              if (result.isSuccess) {
                Navigator.pop(context);
              }
            },
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        return Scaffold(
          body: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    HeaderDisplay(value: _controller.formattedAmount),

                    Expanded(child: _buildContent()),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (_controller.isLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    if (_controller.installmentOptions.isNotEmpty) {
      return InstallmentList(
        installments: _controller.installmentOptions,
        onInstallmentSelected: _controller.selectInstallment,
      );
    }

    return PaymentMethodList(
      methods: _controller.availableMethodsUi,
      onMethodSelected: (id) {
        final method = _controller.availableMethodsUi.firstWhere(
          (m) => m.id == id,
        );
        _controller.selectMethod(method);
      },
    );
  }
}
