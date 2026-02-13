sealed class PaymentResult {}

class SuccessResult extends PaymentResult {
  final String transactionId;
  final String? message;
  SuccessResult(this.transactionId, {this.message});
}

class FailureResult extends PaymentResult {
  final String errorCode;
  final String errorMessage;
  FailureResult(this.errorCode, this.errorMessage);
}

class CancelledResult extends PaymentResult {
  final String? message;
  CancelledResult({this.message});
}