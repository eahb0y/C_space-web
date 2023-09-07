import 'package:c_space_web/router/rout.dart';
import 'package:c_space_web/router/rout_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:c_space_web/injection_container.dart' as di;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAOzZf59N8bARmLBpLcT4Y-7_An7ts3O8s",
      appId: "1:928146380304:web:3f0746a30acfdc3f155c95",
      messagingSenderId: "928146380304",
      projectId: "cweb-8f640",
      authDomain: "cweb-8f640.firebaseapp.com",
      storageBucket: "cweb-8f640.appspot.com",
      measurementId: "G-EFX147RTHH",
    ),
  );
  runApp(const MyApp());
  di.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutName.initial,
      onGenerateRoute: Rout.controller,
    );
  }
}
