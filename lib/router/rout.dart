import 'package:c_space_web/feature/login/page/login_page.dart';
import 'package:c_space_web/feature/main/presentation/pages/main_page.dart';
import 'package:c_space_web/feature/splash/presentation/page/splash_page.dart';
import 'package:c_space_web/feature/stop_time/presentation/arguments/client_time_argument.dart';
import 'package:c_space_web/feature/stop_time/presentation/page/stop_time_page.dart';
import 'package:c_space_web/feature/total_pay/presentation/bloc/total_pay_bloc.dart';
import 'package:c_space_web/feature/total_pay/presentation/page/total_pay.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:c_space_web/router/rout_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();


class Rout {
  Rout._();

  static Route<dynamic> controller(RouteSettings settings) {
    switch (settings.name) {
      case RoutName.initial:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case RoutName.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case RoutName.main:
        return MaterialPageRoute(builder: (_) => MainPage());
      case RoutName.stopTime:
        return MaterialPageRoute(builder: (_) => const StopTime());
      case RoutName.totalPay:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => sl<TotalPayBloc>()..add(CalcTotalTime()),
              child: TotalPay(arguments: settings.arguments is ClientGetTimeArguments
                  ? settings.arguments as ClientGetTimeArguments
                  : null,),
            ));
      default:
        throw('The rout does not exist');
    }
  }
}