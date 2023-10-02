import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'client_event.dart';

part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  String currentDay = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  ClientBloc() : super(MainInitial()) {
    on<TimerStartEvent>(_startTimer);
  }

  Future<void> _startTimer(
      TimerStartEvent event, Emitter<ClientState> emit) async {
    await FirebaseFirestore.instance
        .collection('hour')
        .doc(sl<LocalSource>().getClientName())
        .set({
      'name': sl<LocalSource>().getClientName(),
      'date': currentDay,
    });
    sl<LocalSource>().saveDateTime(currentDay);
    emit(ClientTimerCompleted(dateTime: currentDay));
  }
}
