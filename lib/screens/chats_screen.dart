import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/models/chat_model.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final List<ChatModel> chats = [];

  @override
  void initState() {
    super.initState();
    _getChats();
  }

  void _getChats() async {
    final user = FirebaseAuth.instance.currentUser!;
    final chatsSnapshots = await FirebaseFirestore.instance
        .collection('chats')
        .where('chatUsersId', arrayContains: user.uid)
        .get();
    final loadedChats = chatsSnapshots.docs.map((chat) {
      return ChatModel(
        id: chat.id,
        chatUsersId: (chat['chatUsersId'] as List).cast<String>(),
        name: chat['name'],
      );
    }).toList();

    setState(() {
      chats.clear();
      chats.addAll(loadedChats);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(chats[index].id),
        ),
      ),
    );
  }
}
