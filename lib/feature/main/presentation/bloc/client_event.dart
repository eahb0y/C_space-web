part of 'client_bloc.dart';

abstract class ClientEvent extends Equatable {}

class SetStartTime extends ClientEvent{
  final String name;
  SetStartTime({required this.name});
  @override
  List<Object?> get props => [name];

}
