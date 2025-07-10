import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

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
          itemBuilder: (ctx, index) =>
              Text(loadedMessages[index].data()['text']),
        );
      },
    );
  }
}
