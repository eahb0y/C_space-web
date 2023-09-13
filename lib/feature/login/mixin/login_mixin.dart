import 'package:flutter/cupertino.dart';

mixin LoginMixin{
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;

  initController(){
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
  }
}