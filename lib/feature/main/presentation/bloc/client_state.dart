part of 'client_bloc.dart';

sealed class ClientState extends Equatable {}

final class MainInitial extends ClientState {
  MainInitial();

  @override
  List<Object?> get props => [];
}

final class ClientTimerCompleted extends ClientState {
  final int? totalTime;
  final int? totalPay;
  final String? dateTime;

  ClientTimerCompleted({this.totalPay, this.totalTime, this.dateTime});

  @override
  List<Object?> get props => [];
}

// final class ClientTimerDoneState extends ClientState {
//   ClientTimerDoneState();
//
//   @override
//   List<Object?> get props => [];
// }
