part of 'total_pay_bloc.dart';

class TotalPayState extends Equatable {
  final bool isLoading;
  final int? totalTime;
  final int? totalPay;
  final String? value;
  final bool isSelected;
  final String? paymentMethod;

  const TotalPayState(
      {this.totalPay,
      this.totalTime,
      required this.isLoading,
      this.value,
      required this.isSelected,
      this.paymentMethod});

  TotalPayState copyWith({
    int? totalTime,
    int? totalPay,
    bool? isLoading,
    String? value,
    bool? isSelected,
    String? paymentMethod,
  }) {
    return TotalPayState(
      totalPay: totalPay ?? this.totalPay,
      totalTime: totalTime ?? this.totalTime,
      isLoading: isLoading ?? this.isLoading,
      value: value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  @override
  List<Object?> get props =>
      [totalTime, totalPay, isLoading, value, isSelected, paymentMethod];
}
