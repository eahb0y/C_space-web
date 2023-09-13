part of 'client_bloc.dart';

sealed class ClientState {}

class ClientInitial extends ClientState {}

class ClientTimerCompleted extends ClientState{
  final int? totalTime;
  final int? totalPay;
  ClientTimerCompleted({this.totalPay, this.totalTime});
}
