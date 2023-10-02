import 'dart:async';

import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/feature/total_pay/presentation/arguments/client_get_time_argument.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

part 'total_pay_event.dart';

part 'total_pay_state.dart';

class TotalPayBloc extends Bloc<TotalPayEvent, TotalPayState> {
  String currentDay = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  TotalPayBloc()
      : super(const TotalPayState(
          isLoading: false,
          isSelected: false,
        )) {
    on<CalcTotalTime>(_calcTotalTime);
    on<SelectPaymentType>(_selectValue);
    on<OnPayEvent>(_payMethod);
    on<CreditCardMethod>(_selectPaymentMethod);
  }

  Future<void> _calcTotalTime(
      CalcTotalTime event, Emitter<TotalPayState> emit) async {
    emit(state.copyWith(isLoading: true));
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
      state.copyWith(
        totalTime: timeDifference.inMinutes.abs(),
        totalPay: payTime,
        isLoading: false,
      ),
    );
  }

  void _selectValue(SelectPaymentType event, Emitter<TotalPayState> emit) {
    emit(state.copyWith(value: event.value));
  }

  Future<void> _payMethod(OnPayEvent event, Emitter<TotalPayState> emit) async {
    if (await canLaunch(event.method)) {
      await launch(event.method);
    } else {
      throw 'Could not launch ${event.method}';
    }
  }

  void _selectPaymentMethod(
      CreditCardMethod event, Emitter<TotalPayState> emit) {
    emit(state.copyWith(paymentMethod: event.payMethod, isSelected: !event.select));
  }
}
