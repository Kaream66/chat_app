import 'package:chats_app/constants.dart';
import 'package:chats_app/helper/show_snackBar.dart';
import 'package:chats_app/pages/chat_page.dart';
import 'package:chats_app/pages/cubits/auth_cubit/cubit/auth_cubit.dart';
import 'package:chats_app/pages/cubits/chat_cubit/cubit/chat_cubit.dart';
import 'package:chats_app/pages/register_page.dart';
import 'package:chats_app/widgets/custom_button.dart';
import 'package:chats_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  static String id = 'loginPage';
  bool isLoading = false;
  String? email;
  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, ChatPage.id);
          isLoading = false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errMessage);
          isLoading = false;
        }
      },
      child: ModalProgressHUD(
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
                        'LOGIN',
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
                        BlocProvider.of<AuthCubit>(context)
                            .LoginUser(email: email!, password: password!);
                        Navigator.pushNamed(context, ChatPage.id);
                      } else {
                        showSnackBar(context, 'inCorrect Data');
                      }
                    },
                    text: 'LOGIN',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'don\'t have account? ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: const Text(
                          ' Register',
                          style: TextStyle(color: Color(0xff304FFE)),
                        ),
                      )
                    ],
                  ),
                  // const Spacer(
                  //   flex: 3,
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {}
}
//  try {
//       await signIn();
//       Navigator.pushNamed(context, ChatPage.id, arguments: email);
//         } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         showSnackBar(context, 'user not found');
//       } else if (e.code == 'wrong-password') {
//         showSnackBar(context, 'wrong password');
//       }
        
//                      }
//                      catch(e){
//                       print(e);
//         showSnackBar(context, 'There was an error');
//                      }