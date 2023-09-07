import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'client_event.dart';

part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  String currentDay = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  ClientBloc() : super(ClientInitial()) {
    on<SetStartTime>(_setTime);
  }

  Future<void> _setTime(SetStartTime event, Emitter<ClientState> emit) async {
    await FirebaseFirestore.instance
        .collection('hour')
        .doc(event.name)
        .set({
      'name': event.name,
      'date': currentDay,
    });
  }
}
