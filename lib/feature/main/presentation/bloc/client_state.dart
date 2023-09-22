part of 'client_bloc.dart';

sealed class ClientState {}

class ClientInitial extends ClientState {}

class ClientTimerCompleted extends ClientState{
  final int? totalTime;
  final int? totalPay;
  final String? dateTime;
  ClientTimerCompleted({this.totalPay, this.totalTime, this.dateTime});
}
