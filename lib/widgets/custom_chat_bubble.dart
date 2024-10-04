import 'package:chats_app/models/messages_model.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
    ChatBubble({super.key,required this.color,required this.message });

   final Color color;
   final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(

        padding:const EdgeInsets.only(left: 16.0,top: 20,bottom: 20,right: 16.0),
        margin:const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),

        decoration: BoxDecoration(
          borderRadius:const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),

          ),
          color: color,
        ),
        child: Text(
         message.message,
          style:const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ChatBubbleFromOtehers extends StatelessWidget {
  ChatBubbleFromOtehers({super.key,required this.message });


  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(

        padding:const EdgeInsets.only(left: 16.0,top: 20,bottom: 20,right: 16.0),
        margin:const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),

        decoration:const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),

          ),
          color: Color(0xff0277BD),
        ),
        child: Text(
          message.message,
          style:const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}