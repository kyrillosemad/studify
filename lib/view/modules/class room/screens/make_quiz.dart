import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/view%20model/events/events_bloc.dart';
import 'package:studify/view/modules/class%20room/widgets/form_field.dart';
import 'package:studify/view/modules/class%20room/widgets/questions_part.dart.dart';
import 'package:studify/view/modules/class%20room/widgets/save_quiz_button.dart';

class MakeQuiz extends StatelessWidget {
  const MakeQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EventsBloc(),
        child: Builder(
          builder: (context) {
            var controller = context.read<EventsBloc>();
            return Scaffold(
              appBar: AppBar(
                title: const Text("Create Quiz"),
                centerTitle: true,
                backgroundColor: MyColors().mainColors,
                elevation: 0,
              ),
              body: Padding(
                padding: EdgeInsets.all(4.w),
                child: Form(
                  key: controller.quizFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h),
                        FormFieldPart(
                          keyboardType: TextInputType.text,
                          controller: controller.quizNameCont,
                          hint: "Enter Quiz Name",
                          icon: Icons.title,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Quiz Name cannot be empty.";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.h),
                        FormFieldPart(
                          controller: controller.quizScoreCont,
                          hint: "Enter Quiz Score",
                          icon: Icons.score,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Quiz Score cannot be empty.";
                            }
                            final number = int.tryParse(value);
                            if (number == null || number <= 0) {
                              return "Quiz Score must be a valid number greater than 0.";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 2.h),
                        Divider(thickness: 1.5, color: MyColors().mainColors),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Questions",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors().mainColors),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                controller.add(AddQuestion());
                              },
                              icon: const Icon(Icons.add),
                              label: const Text("Add"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.sp),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.sp, vertical: 4.sp),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 2.h),
                        BlocBuilder<EventsBloc, EventsState>(
                          builder: (context, state) {
                            return QuestionsPart(
                              numOfQuestions: controller.numOfQuestions,
                              questions: controller.questions,
                              controller: controller,
                            );
                          },
                        ),
                        SizedBox(height: 2.h),
                        SaveQuizButton(
                          formKey: controller.quizFormKey,
                          classId: controller.classId,
                          quizName: controller.quizNameCont,
                          eventId: controller.eventId,
                          quizScore: controller.quizScoreCont,
                          questions: controller.questions,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
