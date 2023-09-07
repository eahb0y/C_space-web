import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:c_space_web/router/rout_name.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
      body: Column(
        children: [
          Expanded(
            child: Ink(
              child: Column(
                children: [
                 SafeArea(child: SizedBox(height: 70,)),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Ink(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 70,
                      ),
                      child: Image.asset(
                        'assets/images/c_space.png',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextField(
                      controller: name,
                      decoration: const InputDecoration(
                          hintText: 'Имя', border: OutlineInputBorder()),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextField(
                      controller: surname,
                      decoration: const InputDecoration(
                          hintText: 'Фамилия', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                    color: isEmpty ? Colors.red : Colors.purple),
                minimumSize: const Size.fromHeight(45),
              ),
              onPressed: () {
                if(name.text.isNotEmpty && surname.text.isNotEmpty){
                    sl<LocalSource>()
                        .setClientName(name: name.text, surname: surname.text);
                    Navigator.pushReplacementNamed(context, RoutName.main);
                  }
                else{
                  setState(() {
                    isEmpty = true;
                  });
                }
                  String obj = sl<LocalSource>().getClientName();

              },
              child: Text(
                'Войти',
                style: TextStyle(
                  color: isEmpty ? Colors.red : Colors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ),
      )
    );
  }
}
