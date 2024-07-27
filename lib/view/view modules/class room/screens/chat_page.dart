import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/services/firebase/chat/get_all_msgs.dart';
import 'package:studify/services/firebase/chat/send_msg.dart';
import 'package:studify/view/constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Room',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var classId = Get.arguments['classId'];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Room"),
        centerTitle: true,
        backgroundColor: MyColors().mainColors,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: getAllMsgs(classId),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "Error: ${snapshot.error}",
                    style: TextStyle(
                        fontSize: 15.sp, color: MyColors().mainColors),
                  ));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Text(
                    "No messages found.",
                    style: TextStyle(
                        fontSize: 15.sp, color: MyColors().mainColors),
                  ));
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollController
                        .jumpTo(_scrollController.position.maxScrollExtent);
                  });

                  return ListView.builder(
                    reverse: false,
                    controller: _scrollController,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var msg = snapshot.data![index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 2.w),
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: MyColors().mainColors.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        child: ChatMessage(
                          message: msg['msg'] ?? 'No message',
                          sender: msg['ownerName'] ?? 'Unknown',
                          timestamp: (msg['date'] as Timestamp).toDate(),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          MessageInput(classId: classId),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String message;
  final String sender;
  final DateTime timestamp;

  const ChatMessage({
    Key? key,
    required this.message,
    required this.sender,
    required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: MyColors().mainColors,
            child: Text(
              sender[0],
              style: const TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sender,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: MyColors().mainColors),
                    ),
                    Text(
                      '${timestamp.hour}:${timestamp.minute}',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageInput extends StatefulWidget {
  final String classId;

  const MessageInput({Key? key, required this.classId}) : super(key: key);

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) {
      return;
    }
    sendMsg(widget.classId, _controller.text.trim());
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                hintStyle: TextStyle(color: MyColors().mainColors),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  borderSide:
                      BorderSide(color: MyColors().mainColors.withOpacity(0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  borderSide: BorderSide(color: MyColors().mainColors),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              ),
              onSubmitted: (value) => _sendMessage(),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: MyColors().mainColors,
            ),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
