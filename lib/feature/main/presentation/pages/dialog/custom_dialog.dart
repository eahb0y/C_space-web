import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/core/theme/colors/app_colors.dart';
import 'package:c_space_web/core/theme/text_style/app_text_style.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:c_space_web/router/rout_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Вы хотите выйти ?',
                style: AppTextStyle.timeText),
            const SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment:
              CrossAxisAlignment.center,
              mainAxisAlignment:
              MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      padding:
                      const EdgeInsets.symmetric(
                        vertical: 9,
                        horizontal: 35,
                      ),
                      backgroundColor: LightColorTheme
                          .dialogCancelButton),
                  child: Text(
                    "Нет",
                    style: AppTextStyle
                        .dialogButtonText
                        .copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    sl<LocalSource>().removeStart();
                    sl<LocalSource>().deleteData();
                    sl<LocalSource>()
                        .deleteDateTime();
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutName.initialPage,
                            (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                      padding:
                      const EdgeInsets.symmetric(
                        vertical: 9,
                        horizontal: 35,
                      ),
                      backgroundColor: LightColorTheme
                          .timerBorderSide),
                  child: Text(
                    "Да",
                    style: AppTextStyle
                        .dialogButtonText
                        .copyWith(
                      color: LightColorTheme.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}