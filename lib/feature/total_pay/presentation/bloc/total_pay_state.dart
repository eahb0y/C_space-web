part of 'total_pay_bloc.dart';

class TotalPayState extends Equatable{
  final bool isLoading;
  final int? totalTime;
  final int? totalPay;

  const TotalPayState({
    this.totalPay, this.totalTime, required this.isLoading
});

  TotalPayState copyWith({
    int? totalTime,
    int? totalPay,
    bool? isLoading,
}) {
    return TotalPayState(
      totalPay: totalPay ?? this.totalPay,
      totalTime: totalTime ?? this.totalTime,
      isLoading: isLoading ?? this.isLoading
    );
  }

  @override
  List<Object?> get props => [totalTime, totalPay, isLoading];


}

