part of 'total_pay_bloc.dart';

abstract class TotalPayEvent extends Equatable {}

class CalcTotalTime extends TotalPayEvent {

  CalcTotalTime();

  @override
  List<Object?> get props => [];
}