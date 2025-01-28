import 'package:chats_app/constants.dart';
import 'package:chats_app/models/messages_model.dart';
import 'package:chats_app/pages/cubits/chat_cubit/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  final ScrollController _controller = ScrollController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController controller = TextEditingController();
  List<Message> messagesList = [];

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
   ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              logo,
              height: 50,
            ),
            const Text(
              ' Chat',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList =
                    BlocProvider.of<ChatCubit>(context).messageList;
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                      message: messagesList[index],
                      color: kPrimaryColor,
                    );
                  },
                  itemCount: messagesList.length,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: controller,
              onFieldSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, email: 'email');
                controller.clear();
                _controller.animateTo(0,
                    duration: const Duration(milliseconds: 450),
                    curve: Curves.decelerate);
              },
              decoration: InputDecoration(
                  hintText: 'Send Message',
                  suffixIcon: const Icon(
                    Icons.send_outlined,
                    size: 30,
                    color: kPrimaryColor,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
