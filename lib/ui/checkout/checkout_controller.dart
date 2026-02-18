import 'package:fintesthub_flutter/domain/payment/models/enums/installment_type.dart';
import 'package:fintesthub_flutter/domain/payment/models/installment_details.dart';
import 'package:fintesthub_flutter/domain/payment/models/payment.dart';
import 'package:fintesthub_flutter/domain/payment/models/payment_result.dart';
import 'package:fintesthub_flutter/domain/payment/repositories/payment_processor.dart';
import 'package:fintesthub_flutter/domain/transaction/models/installment_option.dart';
import 'package:fintesthub_flutter/domain/transaction/models/payment_method.dart';
import 'package:fintesthub_flutter/ui/_core/extensions.dart';
import 'package:fintesthub_flutter/ui/checkout/mappers/payment_method_mapper.dart';
import 'package:fintesthub_flutter/ui/checkout/models/payment_method_ui.dart';
import 'package:fintesthub_flutter/ui/checkout/models/payment_request.dart';
import 'package:flutter/material.dart';

import '../../domain/payment/models/enums/payment_type.dart';
import 'models/transaction_result_ui.dart';

class CheckoutController extends ChangeNotifier {
  final PaymentProcessor _paymentProcessor;

  final int amountInCents;

  // -- Estados da UI
  bool isLoading = false;
  TransactionResultUi? transactionResult;
  PaymentMethodUi? selectedMethod;
  List<InstallmentOption> installmentOptions = [];

  /// Métodos de pagamento disponíveis
  final List<PaymentMethod> _availableMethodsDomain = [
    PaymentMethod(
      id: PaymentType.debit.name,
      name: PaymentType.debit.text,
      maxInstallments: 1,
      requiresInstallments: false,
    ),
    PaymentMethod(
      id: PaymentType.credit.name,
      name: PaymentType.credit.text,
      maxInstallments: 4,
      requiresInstallments: true,
    ),
    PaymentMethod(
      id: PaymentType.pix.name,
      name: PaymentType.pix.text,
      maxInstallments: 1,
      requiresInstallments: false,
    ),
    PaymentMethod(
      id: PaymentType.voucher.name,
      name: PaymentType.voucher.text,
      maxInstallments: 1,
      requiresInstallments: false,
    ),
  ];

  CheckoutController({
    required this.amountInCents,
    required PaymentProcessor paymentProcessor,
  }) : _paymentProcessor = paymentProcessor;

  List<PaymentMethodUi> get availableMethodsUi =>
      _availableMethodsDomain.map((m) => m.toUi()).toList();

  String get formattedAmount => amountInCents.toCurrency();

  void selectMethod(PaymentMethodUi method) {
    selectedMethod = method;

    final domainMethod = _availableMethodsDomain.firstWhere(
      (m) => m.id == method.id,
    );

    final paymentType = PaymentType.values.firstWhere(
      (e) => e.name == domainMethod.id,
      orElse: () => PaymentType.debit,
    );

    if (domainMethod.requiresInstallments && domainMethod.maxInstallments > 1) {
      _generateInstallments(domainMethod);
      notifyListeners();
    } else {
      installmentOptions = [];
      _processPayment(
        PaymentRequest(
          amount: amountInCents.toAmount(),
          type: paymentType,
          installments: 1,
        ),
      );
    }
  }

  void selectInstallment(InstallmentOption option) {
    if (selectedMethod == null) return;

    final paymentType = PaymentType.values.firstWhere(
      (e) => e.name == selectedMethod!.id,
      orElse: () => PaymentType.credit,
    );

    _processPayment(
      PaymentRequest(
        amount: amountInCents.toAmount(),
        type: paymentType,
        installments: option.count,
      ),
    );
  }

  void resetTransactionResult() {
    transactionResult = null;
    notifyListeners();
  }

  void clearSelection() {
    selectedMethod = null;
    installmentOptions = [];
    notifyListeners();
  }

  void _generateInstallments(PaymentMethod method) {
    double total = amountInCents.toAmount();
    installmentOptions = List.generate(method.maxInstallments, (i) {
      int count = i + 1;
      return InstallmentOption(
        count: count,
        totalAmount: total,
        interestRate: 0.0,
        monthlyAmount: total / count,
      );
    });
  }

  Future<void> _processPayment(PaymentRequest request) async {
    try {

      isLoading = true;
      notifyListeners();

      InstallmentDetails? installmentDetails = request.installments > 1
          ? InstallmentDetails(
              installments: request.installments,
              installmentType: InstallmentType.merchant,
            )
          : null;

      final result = await _paymentProcessor.processPayment(
        Payment(
          id: DateTime.now().millisecondsSinceEpoch,
          amount: request.amount,
          type: request.type,
          installmentDetails: installmentDetails,
        ),
      );

      transactionResult = switch (result) {
        SuccessResult s => TransactionResultUi(
          isSuccess: true,
          title: "Sucesso!",
          message: s.message ?? "Transação realizada com sucesso.",
        ),
        FailureResult f => TransactionResultUi(
          isSuccess: false,
          title: "Falha na Transação",
          message: "Erro [${f.errorCode}]: ${f.errorMessage}",
        ),
        CancelledResult c => TransactionResultUi(
          isSuccess: false,
          title: "Cancelado",
          message: c.message ?? "A operação foi interrompida.",
        ),
        Future<PaymentResult>() => throw UnimplementedError(),
      };
    } catch (e) {
      debugPrint(e.toString());
      transactionResult = TransactionResultUi(
        isSuccess: false,
        title: "Erro",
        message: "Ocorreu um erro ao processar o pagamento.",
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
