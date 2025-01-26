import 'package:bloc/bloc.dart';
import 'package:chats_app/constants.dart';
import 'package:chats_app/models/messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  void sendMessage({required String message, required String email}) {
    messages.add({kMessage: message, kCreatedAt: DateTime.now(), 'id': email});
  }

  void getMessage() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      List<Message> messagesList = [];
      for (var doc in event.docs) {
        messagesList.add(Message.fromJason(doc));
      }
      emit(ChatSuccess(message: messagesList));
    });
  }
}
