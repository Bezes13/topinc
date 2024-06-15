import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:topinc/services/auth/auth_service.dart';
import 'package:topinc/services/chat/chat_sersvice.dart';

import 'chat_bubble.dart';
import 'my_text_field.dart';

class ChatTab extends StatefulWidget {
  final String receiverId;
  final String topic;

  const ChatTab({super.key, required this.receiverId, required this.topic});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  final AuthService _authService = AuthService();

  final ChatService _chatService = ChatService();

  final TextEditingController _messageController = TextEditingController();
  String senderID = "";

  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    senderID = _authService.getCurrentUser()!.uid;
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });

    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverId, _messageController.text, widget.topic);

      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildMessagesList(widget.topic)),
        _buildUserInput()
      ],
    );
  }

  Widget _buildMessagesList(String topic) {
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverId, senderID, topic),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildMessagesListItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessagesListItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    var alignment = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        ChatBubble(message: data["message"], isCurrentUser: isUser),
      ],
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
              child: MyTextField(
            controller: _messageController,
            hintText: "Type a message",
            obscure: false,
            focusNode: myFocusNode,
          )),
          Container(
              decoration: const BoxDecoration(
                  color: Colors.green, shape: BoxShape.circle),
              margin: const EdgeInsets.only(right: 25),
              child: IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onPressed: sendMessage,
              ))
        ],
      ),
    );
  }
}
