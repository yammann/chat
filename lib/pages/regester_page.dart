import 'package:chat/constens/colors.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/widgets/my_bottun.dart';
import 'package:chat/widgets/my_snackbar.dart';
import 'package:chat/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Regester extends StatefulWidget {
  Regester({super.key});
  static String id = "RegesterPage";

  @override
  State<Regester> createState() => _RegesterState();
}

class _RegesterState extends State<Regester> {
  final email = TextEditingController();

  final password = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey();

  bool isLoding=false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoding,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formkey,
          child: Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(
                  flex: 2,
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
                Spacer(
                  flex: 2,
                ),
                Row(
                  children: [
                    Text(
                      "REGESTER :",
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
                  type: TextInputType.emailAddress,
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
                  title: "Regester",
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        isLoding=!isLoding;
                      });
                      try {
                        await regesterUser();
                       Navigator.pushReplacementNamed(context, ChatPage.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          MySnackBar(
                              context, 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          MySnackBar(context,
                              'The account already exists for that email.');
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
                      "already have an account ? ",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, LoginPage.id);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Color.fromARGB(255, 146, 204, 245),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                  ],
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> regesterUser() async {
    UserCredential userAuth = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email.text, password: password.text);
  }
}
