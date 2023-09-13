import 'package:c_space_web/feature/login/bloc/login_bloc.dart';
import 'package:c_space_web/feature/register/presentation/bloc/auth_bloc.dart';
import 'package:c_space_web/feature/total_pay/presentation/bloc/total_pay_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/local_data/local_source.dart';

final sl = GetIt.instance;
late SharedPreferences preferences;

Future<void> init() async {
  await initPreferences();
  sl.registerSingleton<LocalSource>(LocalSource(preferences));
  sl.registerFactory(() => LoginBloc());
  sl.registerFactory(() => TotalPayBloc());
  sl.registerFactory(() => AuthBloc());
}

Future<void> initPreferences() async {
  preferences = await SharedPreferences.getInstance();
}
