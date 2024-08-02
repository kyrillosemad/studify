import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/services/firebase/events/get_quiz.dart';
import 'package:studify/services/firebase/events/quiz_result.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/quiz_option_row.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/send_button.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  var eventId = Get.arguments['quizId'];
  var classId = Get.arguments['classId'];
  List<Answers> answers = [];

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
                SizedBox(height: 1.h),
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
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${index + 1} - ${snapshot.data[index]['question']}",
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                  SizedBox(height: 1.h),
                                  QuizOptionRow(
                                    answer: answers[index],
                                    optionText: snapshot.data[index]['op1'],
                                    value: "1",
                                    onChanged: (newValue) {
                                      setState(() {
                                        answers[index].answer = newValue!;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 1.h),
                                  QuizOptionRow(
                                    answer: answers[index],
                                    optionText: snapshot.data[index]['op2'],
                                    value: "2",
                                    onChanged: (newValue) {
                                      setState(() {
                                        answers[index].answer = newValue!;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 1.h),
                                  QuizOptionRow(
                                    answer: answers[index],
                                    optionText: snapshot.data[index]['op3'],
                                    value: "3",
                                    onChanged: (newValue) {
                                      setState(() {
                                        answers[index].answer = newValue!;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 1.h),
                                  QuizOptionRow(
                                    answer: answers[index],
                                    optionText: snapshot.data[index]['op4'],
                                    value: "4",
                                    onChanged: (newValue) {
                                      setState(() {
                                        answers[index].answer = newValue!;
                                      });
                                    },
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
                SizedBox(height: 1.h),
                SendButton(
                  onPressed: () {
                    Get.defaultDialog(
                      buttonColor: MyColors().mainColors,
                      cancelTextColor: MyColors().mainColors,
                      confirmTextColor: Colors.white,
                      title: "Send?",
                      titleStyle: TextStyle(color: MyColors().mainColors),
                      content: Text(
                        "You can't go back again.",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Answers {
  String answer;
  Answers() : answer = '';
}
