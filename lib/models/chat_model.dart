class ChatModel {
  final String id;
  final String name;
  final List<String> chatUsersId;

  ChatModel({
    required this.id,
    required this.chatUsersId,
    required this.name,
  });
}
