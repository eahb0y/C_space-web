import 'package:c_space_web/core/functions/base_functions.dart';
import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/feature/total_pay/presentation/bloc/total_pay_bloc.dart';
import 'package:c_space_web/feature/total_pay/presentation/page/widget/payment_methods.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:c_space_web/router/rout_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalPay extends StatefulWidget {
  const TotalPay({
    super.key,
  });

  @override
  State<TotalPay> createState() => _TotalPayState();
}

class _TotalPayState extends State<TotalPay> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TotalPayBloc, TotalPayState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Общий"),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: Center(
          child: state.isLoading
              ? const CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.only(top: 25, left: 30, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Text(
                                'Общая сумма : ',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700),
                              ),
                              Text(
                                '${Functions.moneyFormatNoSum(state.totalPay ?? 0)} sum',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Время работы : ",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700),
                              ),
                              Text(
                                '${state.totalTime} минута',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      const Column(
                        children: [
                          Text(
                            'Методы оплат',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PaymentMethods(text: "PayMe"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  PaymentMethods(text: "Uzum"),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PaymentMethods(text: "Click"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  PaymentMethods(text: "Anor Bank"),
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: SafeArea(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutName.main,
                  (route) => false,
                );
                sl<LocalSource>().removeStart();
              },
              child: const Text("Назад"),
            ),
          ),
        ),
      );
    });
  }
}
