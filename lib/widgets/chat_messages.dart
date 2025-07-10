import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/widgets/chat_message.dart';

class ChatMessages extends StatelessWidget {
  final String chatId;

  const ChatMessages({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, snapshots) {
        if (snapshots.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
          return const Center(
            child: Text('Sem mensagens.'),
          );
        }
        if (snapshots.hasError) {
          return const Center(
            child: Text('Algo deu errado.'),
          );
        }
        final loadedMessages = snapshots.data!.docs;
        return ListView.builder(
          padding: EdgeInsets.only(bottom: 8),
          reverse: true,
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            final bool isFirst =
                index == loadedMessages.length - 1 ||
                loadedMessages[index].data()['senderId'] !=
                    loadedMessages[index + 1].data()['senderId'];
            return ChatMessage(
              senderName: loadedMessages[index].data()['senderName'],
              text: loadedMessages[index].data()['text'],
              isMine:
                  loadedMessages[index].data()['senderId'] ==
                  FirebaseAuth.instance.currentUser!.uid,
              isFirst: isFirst,
            );
          },
        );
      },
    );
  }
}
