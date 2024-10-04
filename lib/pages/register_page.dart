import 'package:chats_app/constants.dart';
import 'package:chats_app/helper/show_snackBar.dart';
import 'package:chats_app/pages/chat_page.dart';
import 'package:chats_app/widgets/custom_button.dart';
import 'package:chats_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  static String id = 'rigesterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;
  String? password;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/images/hatphoto.png',
                  height: 100,
                ),
                const Text(
                  'Scholar Chat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontFamily: 'Pacifico',
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                const Row(
                  children: [
                    Text(
                      'REGISTER',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomFormTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Enter your email',
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomFormTextField(
                  obscure: true,
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Enter your password',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser();
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, 'Weak password');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, 'Email is already in use');
                        }
                      } catch (e) {
                        showSnackBar(context, 'There was an error');
                      }
                    }
                    isLoading = false;
                    setState(() {});
                  },
                  text: 'REGISTER',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have account ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, 'LoginPage');
                      },
                      child: const Text(
                        ' Login',
                        style: TextStyle(color: Color(0xff304FFE)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
