part of 'total_pay_bloc.dart';

abstract class TotalPayEvent extends Equatable {
  const TotalPayEvent();
}

class CalcTotalTime extends TotalPayEvent {
  const CalcTotalTime();

  @override
  List<Object?> get props => [];
}

class SelectPaymentType extends TotalPayEvent {
  final String value;

  const SelectPaymentType({required this.value});

  @override
  List<Object?> get props => [value];
}

class OnPayEvent extends TotalPayEvent {
  final String method;

  const OnPayEvent({
    required this.method,
  });

  @override
  List<Object?> get props => [method];
}

class CreditCardMethod extends TotalPayEvent{
  final bool select;
  final String payMethod;
  const CreditCardMethod({required this.payMethod, required this.select});
  @override
  List<Object?> get props => [payMethod, select];

}
