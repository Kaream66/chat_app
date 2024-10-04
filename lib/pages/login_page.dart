import 'package:chats_app/constants.dart';
import 'package:chats_app/helper/show_snackBar.dart';
import 'package:chats_app/pages/chat_page.dart';
import 'package:chats_app/pages/register_page.dart';
import 'package:chats_app/widgets/custom_button.dart';
import 'package:chats_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
   const LoginPage({super.key});
 static String id ='loginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 bool isLoading = false;
 String? email;
 String? password;

 GlobalKey<FormState>formKey =GlobalKey();

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
               const SizedBox(height: 75,),
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
               const SizedBox(height: 100,),
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
                  onChanged: (data){
                    email =data;
                  },
                  hintText: 'Enter your email',
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomFormTextField(
                  onChanged: (data){
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
                      isLoading =true;
                      setState(() { });
        try {
      await signIn();
      Navigator.pushNamed(context, ChatPage.id, arguments: email);
        } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'user not found');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'wrong password');
      }
        
                     }
                     catch(e){
                      print(e);
        showSnackBar(context, 'There was an error');
                     }
       
      }
      isLoading =false;
      setState(() {
        
      });
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
    );
  }
  Future<void> signIn() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

}
 