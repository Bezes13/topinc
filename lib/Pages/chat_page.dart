import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topinc/components/chat_tab.dart';
import 'package:topinc/components/my_button.dart';
import 'package:topinc/components/my_text_field.dart';
import 'package:dynamic_tabbar/dynamic_tabbar.dart';

import '../services/auth/auth_service.dart';
import '../services/chat/chat_sersvice.dart';

class ChatPage extends StatefulWidget {
  final String receiverName;
  final String receiverId;

  const ChatPage(
      {super.key, required this.receiverName, required this.receiverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController _topicController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
  }

  void createTopic(int index) async {
    if (_topicController.text.isNotEmpty) {
      await _chatService.createTopics(widget.receiverId, _topicController.text, index);

      _topicController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverName),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: _buildTopicList(),
    );
  }

  Widget _buildTopicList() {
    String senderID = _authService.getCurrentUser()!.uid;

    return StreamBuilder(
        stream: _chatService.getTopics(widget.receiverId, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }
          return DynamicTabBarWidget(
            showBackIcon: false,
            showNextIcon: false,
            isScrollable: true,
            onTabChanged: (_)=>{},
            dynamicTabs: snapshot.data!.docs
                .map<TabData>((doc) => _buildTopicTab(doc))
                .toList()
                .followedBy([
              _buildAddTab(snapshot.data!.docs.length)]).toList(),
            onTabControllerUpdated: (_) {},
          );
        });
  }

  _buildTopicTab(QueryDocumentSnapshot<Object?> doc) {
    return TabData(
      title: Tab(text: doc['topic']),
      index: doc['index'],
      content: ChatTab(
          receiverId: widget.receiverId, topic: doc['topic']),
    );
  }

  _buildAddTab(int index){
    return TabData(
        title: const Tab(icon: Icon(Icons.add)),
        index: index,
        content: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Create a new Chat Topic:",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16)),
              SizedBox(height: 25.0,),
              MyTextField(
                  hintText: "new Topic",
                  obscure: false,
                  controller: _topicController,
                  focusNode: null),
              SizedBox(height: 10.0,),
              MyButton(text: "Create Topic", onTap: () => createTopic(index))
            ],
          ),
        ));
  }
}
