import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/data/firebase/class/add_event.dart';
import 'package:studify/view/constants/colors.dart';

class MakeQuiz extends StatefulWidget {
  const MakeQuiz({super.key});

  @override
  State<MakeQuiz> createState() => _MakeQuizState();
}

class _MakeQuizState extends State<MakeQuiz> {
  TextEditingController quizNameCont = TextEditingController();
  TextEditingController quizSCoreCont = TextEditingController();
  int numOfQuestions = 0;
  List<QuizQuestion> questions = [];
  var classId = Get.arguments['classId'];
  var eventId = Random().nextInt(10000000).toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
        centerTitle: true,
        backgroundColor: MyColors().mainColors,
      ),
      body: Center(
        child: SizedBox(
          width: 95.w,
          height: 100.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              TextFormField(
                controller: quizNameCont,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.abc),
                  focusedBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  hintText: "Quiz Name",
                ),
              ),
              SizedBox(height: 1.h),
              TextFormField(
                controller: quizSCoreCont,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.abc),
                  focusedBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  hintText: "Quiz Score",
                ),
              ),
              SizedBox(height: 1.h),
              Divider(thickness: 1.5, color: MyColors().mainColors),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Questions >>",
                    style: TextStyle(
                        fontSize: 15.sp, color: MyColors().mainColors),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        numOfQuestions++;
                        questions.add(QuizQuestion());
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      width: 15.w,
                      height: 4.h,
                      child: Center(
                        child: Icon(Icons.add, color: MyColors().mainColors),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 1.h),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: numOfQuestions,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                        color: MyColors().mainColors.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      margin: EdgeInsets.all(5.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${index + 1} -",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    questions.removeAt(index);
                                    numOfQuestions--;
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.sp),
                            height: 6.h,
                            child: TextFormField(
                              controller: questions[index].questionController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.abc),
                                focusedBorder: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(),
                                hintText: "Question",
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              SizedBox(
                                width: 10.w,
                                child: Radio<String>(
                                  value: "1",
                                  groupValue: questions[index].correctOp,
                                  onChanged: (value) {
                                    setState(() {
                                      questions[index].correctOp = value!;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: questions[index].op1,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    hintText: "Option 1",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              SizedBox(
                                width: 10.w,
                                child: Radio<String>(
                                  value: "2",
                                  groupValue: questions[index].correctOp,
                                  onChanged: (value) {
                                    setState(() {
                                      questions[index].correctOp = value!;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: questions[index].op2,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    hintText: "Option 2",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              SizedBox(
                                width: 10.w,
                                child: Radio<String>(
                                  value: "3",
                                  groupValue: questions[index].correctOp,
                                  onChanged: (value) {
                                    setState(() {
                                      questions[index].correctOp = value!;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: questions[index].op3,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    hintText: "Option 3",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              SizedBox(
                                width: 10.w,
                                child: Radio<String>(
                                  value: "4",
                                  groupValue: questions[index].correctOp,
                                  onChanged: (value) {
                                    setState(() {
                                      questions[index].correctOp = value!;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: questions[index].op4,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    hintText: "Option 4",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  List<Map<String, dynamic>> questionsData =
                      questions.map((question) => question.toMap()).toList();

                  addEvent(classId, quizNameCont.text, eventId,
                      quizSCoreCont.text, questionsData);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors().mainColors,
                ),
                child: const Center(child: Text('Save the Quiz')),
              ),
              SizedBox(height: 1.h),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizQuestion {
  TextEditingController questionController;
  TextEditingController op1;
  TextEditingController op2;
  TextEditingController op3;
  TextEditingController op4;
  String correctOp;

  QuizQuestion()
      : questionController = TextEditingController(),
        op1 = TextEditingController(),
        op2 = TextEditingController(),
        op3 = TextEditingController(),
        op4 = TextEditingController(),
        correctOp = "";

  Map<String, dynamic> toMap() {
    return {
      'question': questionController.text,
      'op1': op1.text,
      'op2': op2.text,
      'op3': op3.text,
      'op4': op4.text,
      'correctOp': correctOp,
    };
  }
}
