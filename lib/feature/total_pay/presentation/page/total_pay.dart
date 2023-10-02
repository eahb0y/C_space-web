import 'package:c_space_web/constants.dart';
import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/core/theme/colors/app_colors.dart';
import 'package:c_space_web/core/theme/text_style/app_text_style.dart';
import 'package:c_space_web/core/widgets/cutom_button/custom_button.dart';
import 'package:c_space_web/feature/main/presentation/pages/widgets/timer_widget.dart';
import 'package:c_space_web/feature/total_pay/presentation/bloc/total_pay_bloc.dart';
import 'package:c_space_web/feature/total_pay/presentation/page/widget/payment_methods_widget.dart';
import 'package:c_space_web/feature/total_pay/presentation/page/widget/total_sum_widget.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                : Column(
                    children: [
                      TimerWidget(
                        statusUpdateTime: DateTime.tryParse(
                            '${state.totalTime ?? DateTime.now()}'),
                      ),
                      TotalSumWidget(totalSum: state.totalPay ?? 0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Способ оплаты:",
                            style: AppTextStyle.radialChart,
                          ),
                          Card(
                            color: Colors.transparent,
                            elevation: 0,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                        value: Constants.paymentType[0],
                                        groupValue: state.value,
                                        onChanged: (value) {
                                          context.read<TotalPayBloc>().add(
                                                SelectPaymentType(
                                                    value: value.toString()),
                                              );
                                        }),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svg/ic_credit_card.svg'),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text('Картой'),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<TotalPayBloc>()
                                            .add(CreditCardMethod(
                                              payMethod:
                                                  'https://transfer.paycom.uz/60c9fdbbd54cf9fd7ef9aba8',
                                              select: state.isSelected,
                                            ));
                                      },
                                      child: PaymentMethodWidget(
                                        borderColor: LightColorTheme.payme,
                                        svgPicture: 'assets/svg/ic_payme.svg',
                                        borderState: state.isSelected,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<TotalPayBloc>()
                                            .add(CreditCardMethod(
                                              payMethod:
                                                  'https://payment.apelsin.uz/merchant?serviceId=975110',
                                              select: state.isSelected,
                                            ));
                                      },
                                      child: PaymentMethodWidget(
                                        borderColor: LightColorTheme.uzum,
                                        svgPicture: 'assets/svg/ic_uzum.svg',
                                        borderState: state.isSelected,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<TotalPayBloc>()
                                            .add(CreditCardMethod(
                                              payMethod:
                                                  'https://indoor.click.uz/pay?id=021696&t=0',
                                              select: state.isSelected,
                                            ));
                                      },
                                      child: PaymentMethodWidget(
                                        borderColor: LightColorTheme.click,
                                        svgPicture: 'assets/svg/ic_click.svg',
                                        borderState: state.isSelected,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Card(
                            color: Colors.transparent,
                            elevation: 0,
                            child: Row(
                              children: [
                                Radio(
                                  value: Constants.paymentType[1],
                                  groupValue: state.value,
                                  onChanged: (value) {
                                    context.read<TotalPayBloc>().add(
                                          SelectPaymentType(
                                              value: value.toString()),
                                        );
                                  },
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/svg/ic_credit_card.svg'),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text('Картой'),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 50,
          ),
          child: CustomButton(
            buttonText: 'Назад',
            onPressed: () {
              context.read<TotalPayBloc>().add(const OnPayEvent(
                  method: 'https://indoor.click.uz/pay?id=021696&t=0'));
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //   RoutName.main,
              //   (route) => false,
              // );
              sl<LocalSource>().removeStart();
            },
            borderColor: LightColorTheme.buttonBackgroundColor,
            color: LightColorTheme.buttonBackgroundColor,
          ),
        ),
      );
    });
  }
}
