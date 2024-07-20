import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/data/firebase/class/get_quiz.dart';
import 'package:studify/data/firebase/class/quiz_result.dart';
import 'package:studify/view/constants/colors.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  var eventId = Get.arguments['quizId'];
  var classId = Get.arguments['classId'];
  List<Answers> answers = []; // Initialize answers list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
        centerTitle: true,
        backgroundColor: MyColors().mainColors,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
              width: 95.w,
              height: 100.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    height: 79.h,
                    child: FutureBuilder(
                      future: getQuiz(classId, eventId),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index >= answers.length) {
                                answers.add(Answers());
                              }
                              return Container(
                                padding: EdgeInsets.all(5.sp),
                                margin: EdgeInsets.all(5.sp),
                                decoration: BoxDecoration(
                                    color: MyColors().mainColors.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10.sp)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${index + 1} - ${snapshot.data[index]['question']}",
                                      style: TextStyle(fontSize: 15.sp),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10.w,
                                          child: Radio<String>(
                                            value: "1",
                                            groupValue: answers[index].answer,
                                            onChanged: (value) {
                                              setState(() {
                                                answers[index].answer = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                              "${snapshot.data[index]['op1']}"),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10.w,
                                          child: Radio<String>(
                                            value: "2",
                                            groupValue: answers[index].answer,
                                            onChanged: (value) {
                                              setState(() {
                                                answers[index].answer = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                              "${snapshot.data[index]['op2']}"),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10.w,
                                          child: Radio<String>(
                                            value: "3",
                                            groupValue: answers[index].answer,
                                            onChanged: (value) {
                                              setState(() {
                                                answers[index].answer = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                              "${snapshot.data[index]['op3']}"),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10.w,
                                          child: Radio<String>(
                                            value: "4",
                                            groupValue: answers[index].answer,
                                            onChanged: (value) {
                                              setState(() {
                                                answers[index].answer = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                              "${snapshot.data[index]['op4']}"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                          return const Center(child: Text('No data available'));
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.defaultDialog(
                        buttonColor: MyColors().mainColors,
                        cancelTextColor: MyColors().mainColors,
                        confirmTextColor: Colors.white,
                        title: "Send ?",
                        titleStyle: TextStyle(color: MyColors().mainColors),
                        content: Text(
                          "You can't go back again .",
                          style: TextStyle(color: MyColors().mainColors),
                        ),
                        onCancel: () {},
                        onConfirm: () {
                          List newAnswers =
                              answers.map((e) => {"answer": e.answer}).toList();
                          quizResult(classId, eventId, newAnswers);
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10.sp)),
                      width: 80.w,
                      height: 8.h,
                      child: Center(
                        child: Text(
                          "Send",
                          style: TextStyle(fontSize: 15.sp, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class Answers {
  String answer;
  Answers() : answer = '';
}
