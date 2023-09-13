import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/feature/stop_time/presentation/arguments/client_time_argument.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'client_event.dart';

part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  String currentDay = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  ClientBloc() : super(ClientInitial()) {
    on<TimerStartEvent>(_startTimer);
    on<TimerPausedEvent>(_completedTimer);
  }

  Future<void> _startTimer(
      TimerStartEvent event, Emitter<ClientState> emit) async {
    await FirebaseFirestore.instance.collection('hour').doc(sl<LocalSource>().getClientName()).set({
      'name': sl<LocalSource>().getClientName(),
      'date': currentDay,
    });
    emit(ClientTimerCompleted());
  }

  Future<void> _completedTimer(
      TimerPausedEvent event, Emitter<ClientState> emit) async {
    late ClientGetTimeArguments model;
    final request = await FirebaseFirestore.instance
        .collection('hour')
        .where('name', isEqualTo: sl<LocalSource>().getClientName())
        .get();
    for (var element in request.docs) {
      model = ClientGetTimeArguments.fromFirebase(element.data());
    }
    DateTime startTime = DateTime.parse(model.date);
    DateTime endTime = DateTime.parse(currentDay);
    Duration timeDifference = startTime.difference(endTime);
    int payTime = (((timeDifference.inMinutes).abs() / 60) * 20000).ceil();
    emit(
      ClientTimerCompleted(
        totalTime: timeDifference.inMinutes.abs(),
        totalPay: payTime,
      ),
    );
  }
}
