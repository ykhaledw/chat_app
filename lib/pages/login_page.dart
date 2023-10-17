import 'dart:math';

import 'package:chat_app/components/custom_container.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static String id = 'loginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 55,
              ),
              Column(
                children: [
                  Image.asset('assets/images/scholar.png'),
                  Text(
                    'Chat App',
                    style: TextStyle(
                        fontSize: 32, color: Colors.white, fontFamily: 'Itim'),
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),
              //this is the main row********************************
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomText(
                text: 'Email',
                onChanged: (data) {
                  email = data;
                },
                textType: TextInputType.emailAddress,
                starOrNot: false,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                  text: 'Password',
                  onChanged: (data) {
                    password = data;
                  },
                  textType: TextInputType.name,
                  starOrNot: true),
              SizedBox(
                height: 25,
              ),
              CustomButton(
                textTap: 'Sign In',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    isLoading = true;
                    setState(() {});
                    try {
                      await loginUser();
                      showSnackBar(context, 'Success');
                      Navigator.pushNamed(context, ChatPage.id, arguments: email);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'wrong-password') {
                        showSnackBar(context, 'Wrong password.');
                      } else if (e.code == 'user-not-found') {
                        showSnackBar(context, 'No user found for that email.');
                      }
                    } catch (ex) {
                      print(ex);
                      showSnackBar(context, 'There Was an Error');
                    }
                    isLoading = false;
                    setState(() {});
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account ?',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterPage.id);
                    },
                    child: Text(
                      '  Sign Up',
                      style: TextStyle(color: Color(0xffC7EDE6)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
