import 'package:flutter/material.dart';
import 'package:gemini_app/app/controller/chat_controller.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  final ChatController _chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: _chatController.messages.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: index % 2 == 0
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? Colors.grey[300]
                              : Colors.blue[100],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          _chatController.messages[index],
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            Obx(() {
              return _chatController.isLoading.value
                  ? CircularProgressIndicator()
                  : Container();
            }),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.photo),
                    onPressed: () {
                      // Add photo functionality
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _chatController.textController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          _chatController.sendMessage(value);
                          _chatController.textController.clear();
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    color: Colors.blue,
                    onPressed: () {
                      final text = _chatController.textController.text;
                      if (text.isNotEmpty) {
                        _chatController.sendMessage(text);
                        _chatController.textController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
