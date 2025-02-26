import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/view%20model/participants/participants_bloc.dart';
import 'package:studify/view/modules/class%20room/widgets/participants_part.dart';
import 'package:studify/view/shared_widgets/search_field.dart';

class StudentsDegree extends StatelessWidget {
  const StudentsDegree({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParticipantsBloc(),
      child: Builder(
        builder: (context) {
          var controller = context.read<ParticipantsBloc>();
          controller.add(FetchParticipants(controller.classId, ''));
          return Scaffold(
           appBar: AppBar(
                toolbarHeight: 7.h,
                title: Text(
                  "Students Degrees",
                  style: TextStyle(fontSize: 17.sp),
                ),
                backgroundColor: MyColors().mainColors,
                centerTitle: true,
              ),
            body: Center(
              child: SizedBox(
                width: 95.w,
                height: 100.h,
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "You can find here all students with all their degrees in different events",
                        style: TextStyle(
                            fontSize: 13.sp, color: MyColors().mainColors),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SearchField(
                        hint: "Search By Name or ID",
                        onChanged: (value) {
                          controller.add(FetchParticipants(
                              controller.classId, value.toString()));
                        },
                        type: TextInputType.text),
                    SizedBox(
                      height: 2.h,
                    ),
                    Expanded(
                      child: BlocBuilder<ParticipantsBloc, ParticipantsState>(
                        builder: (context, state) {
                          if (state is ParticipantsLoading) {
                            return Center(
                              child: Lottie.asset(
                                'assets/Animation - 1740512569959.json',
                                height: 20.h,
                                fit: BoxFit.contain,
                              ),
                            );
                          } else if (state is ParticipantsLoaded) {
                            if (state.participants.isEmpty) {
                              return Center(
                                  child: Lottie.asset(
                                'assets/Animation - 1740514545687.json',
                                height: 28.h,
                                fit: BoxFit.contain,
                              ));
                            } else {
                              return ParticipantsPart(
                                  type: "studentsDegrees",
                                  controller: controller,
                                  state: state.participants);
                            }
                          } else if (state is ParticipantsError) {
                            return Center(
                              child: Text(
                                "An error occurred: ${state.msg}",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: MyColors().mainColors),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
