part of 'client_bloc.dart';

abstract class ClientEvent extends Equatable {
  const ClientEvent();
}

class TimerStartEvent extends ClientEvent{
  const TimerStartEvent();
  @override
  List<Object?> get props => [];
}

class TimerPausedEvent extends ClientEvent{
  const TimerPausedEvent();
  @override
  List<Object?> get props => [];
}
class MainInitialCallEvent extends ClientEvent {
  const MainInitialCallEvent();

  @override
  List<Object?> get props => [];
}
