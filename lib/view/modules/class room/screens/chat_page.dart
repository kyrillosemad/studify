// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/services/firebase/chat/get_all_msgs.dart';
import 'package:studify/view/modules/class%20room/widgets/chat_msg.dart';
import 'package:studify/view/modules/class%20room/widgets/msg_input.dart';

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
                  return  Center(child:  Lottie.asset(
              'assets/Animation - 1740512569959.json',
              height: 20.h,
              fit: BoxFit.contain,
            ));
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "Error: ${snapshot.error}",
                    style: TextStyle(
                        fontSize: 15.sp, color: MyColors().mainColors),
                  ));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Lottie.asset(
                'assets/Animation - 1740514545687.json',
                height: 28.h,
                fit: BoxFit.contain,
              ));
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollController
                        .jumpTo(_scrollController.position.maxScrollExtent);
                  });
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
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
