import 'package:chats_app/constants.dart';
import 'package:chats_app/models/messages_model.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  final ScrollController _controller = ScrollController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            var data = snapshot.data!.docs[i].data();
            messagesList.add(Message.fromJason(data));
          }

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
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBubble(
                              message: messagesList[index],
                              color: kPrimaryColor,
                            )
                          : ChatBubbleFromOtehers(message: messagesList[index]);
                    },
                    itemCount: messagesList.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: controller,
                    onFieldSubmitted: (data) {
                      messages.add({
                        kMessage: data,
                        kCreatedAt: DateTime.now(),
                        'id': email
                      });
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
        } else {
          return const Text('Loading....');
        }
      },
    );
  }
}
