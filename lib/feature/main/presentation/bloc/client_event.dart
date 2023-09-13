part of 'client_bloc.dart';

abstract class ClientEvent extends Equatable {}

class TimerStartEvent extends ClientEvent{
  TimerStartEvent();
  @override
  List<Object?> get props => [];
}

class TimerPausedEvent extends ClientEvent{
  @override
  List<Object?> get props => [];

}
