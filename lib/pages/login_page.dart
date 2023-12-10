import 'package:chat/constens/colors.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/regester_page.dart';
import 'package:chat/widgets/my_bottun.dart';
import 'package:chat/widgets/my_snackbar.dart';
import 'package:chat/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();

  final password = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey();

  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoding,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 105,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/logo.png"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Scholer Chat",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 105,
                  ),
                  Row(
                    children: [
                      Text(
                        "LOGIN :",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MyTextFormField(
                    hintText: "Email",
                    controller: email,
                    type:TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyTextFormField(
                    hintText: "Password",
                    controller: password,
                    type: TextInputType.visiblePassword,
                    obscure: true,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MyBottun(
                    title: "Login",
                    onPressed: () async {
                     if (formkey.currentState!.validate()) {
                      setState(() {
                        isLoding=!isLoding;
                      });
                      try {
                        await signin();
                        Navigator.pushReplacementNamed(context, ChatPage.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          MySnackBar(
                              context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          MySnackBar(context,
                              'Wrong password provided for that user.');
                        }
                      } catch (e) {
                        print(e);
                      }
                       setState(() {
                        isLoding=!isLoding;
                      });
                    } else {}
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "don't have an account ",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Regester.id);
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: Color.fromARGB(255, 146, 204, 245),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signin() async{
     final userAuth =await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: email.text, password: password.text);
  }
}
