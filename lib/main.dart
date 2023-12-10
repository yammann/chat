import 'package:chat/firebase_options.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/regester_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ScholerChat());
}

class ScholerChat extends StatelessWidget {
  const ScholerChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginPage.id:(context)=>LoginPage(),
        Regester.id:(context) => Regester(),
        ChatPage.id:(context) => ChatPage(),
      },
      initialRoute:LoginPage.id ) ;
  }
}