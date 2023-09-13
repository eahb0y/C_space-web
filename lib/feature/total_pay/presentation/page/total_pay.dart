import 'package:c_space_web/core/functions/base_functions.dart';
import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/feature/stop_time/presentation/arguments/client_time_argument.dart';
import 'package:c_space_web/feature/total_pay/presentation/bloc/total_pay_bloc.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:c_space_web/router/rout_name.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalPay extends StatefulWidget {
  final ClientGetTimeArguments? arguments;

  const TotalPay({
    super.key,
    required this.arguments,
  });

  @override
  State<TotalPay> createState() => _TotalPayState();
}

class _TotalPayState extends State<TotalPay> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TotalPayBloc, TotalPayState>(builder: (context, state) {
      print(state.totalTime);
      return Scaffold(
        body: Center(
          child: state.isLoading
              ? const CircularProgressIndicator()
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Общая сумма'),
                      Text(
                          '${Functions.moneyFormatNoSum(state.totalPay ?? 0)} sum'),
                      Text('${state.totalTime}'),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Text('Методы оплат'),
                          SizedBox(
                            height: 16,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Ink(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Center(child: Text('PayMe')),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Ink(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Center(child: Text('PayMe')),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Ink(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: CachedNetworkImage(imageUrl: "https://cdn.paycom.uz/documentation_assets/payme_01.svg?target=_blank")
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Ink(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Center(child: Text('PayMe')),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
        ),
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RoutName.main,
                    (route) => false,
                  );
                  sl<LocalSource>().removeStart();
                },
                child: const Text('Назад')),
          ],
        ),
      );
    });
  }
}
