import 'package:flutter/material.dart';
import 'package:my_chat/models/chat_model.dart';
import 'package:my_chat/screens/chat_screen.dart';

class ChatsListItem extends StatelessWidget {
  final ChatModel chat;

  const ChatsListItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(),
      title: Text(
        chat.name,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text('TODO: ultima mensagem'),
      trailing: Text('12:30'),
      onTap: () {
        Navigator.of(
          context,
        ).push(
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              chat: chat,
            ),
          ),
        );
      },
    );
  }
}
