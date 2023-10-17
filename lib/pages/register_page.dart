import 'package:chat_app/components/custom_container.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  static String id = 'registerPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                      'Sign Up',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomText(
                  onChanged: (data) {
                    email = data;
                  },
                  text: 'Email',
                  textType: TextInputType.emailAddress,
                  starOrNot: false),
              SizedBox(
                height: 10,
              ),
              CustomText(
                onChanged: (data) {
                  password = data;
                },
                text: 'Password',
                textType: TextInputType.name,
                starOrNot: true,
              ),
              SizedBox(
                height: 25,
              ),
              CustomButton(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    isLoading = true;
                    setState(() {});
                    try {
                      await registerUser();
                      showSnackBar(context, 'Success');
                      Navigator.pushNamed(context, ChatPage.id, arguments: email);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showSnackBar(context, 'weak password');
                      } else if (e.code == 'email-already-in-use') {
                        showSnackBar(context, 'Email Already Exists');
                      }
                    } catch (ex) {
                      print(ex);
                      showSnackBar(context, 'There Was an Error');
                    }
                    isLoading = false;
                    setState(() {});
                  }
                },
                textTap: 'Sign Up',
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account ?',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '  Sign In',
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

  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
