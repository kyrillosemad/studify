import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/core/constants/styles.dart';
import 'package:studify/view%20model/participants/participants_bloc.dart';
import 'package:studify/view/modules/class%20room/widgets/add_participants_button.dart';
import 'package:studify/view/modules/class%20room/widgets/participants_part.dart';
import 'package:studify/view/shared_widgets/search_field.dart';

class Participants extends StatelessWidget {
  const Participants({super.key});

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
              backgroundColor: MyColors().mainColors,
              centerTitle: true,
              title: BlocBuilder<ParticipantsBloc, ParticipantsState>(
                builder: (context, state) {
                  if (state is ParticipantsLoaded) {
                    controller.numOfParticipants = state.participants.length;
                  }
                  return Text(
                      "Participants: (${controller.numOfParticipants})");
                },
              ),
            ),
            body: Center(
              child: SizedBox(
                width: 95.w,
                height: 100.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "You can here find all participants in this class",
                        style: TextStyle(
                            color: MyColors().mainColors, fontSize: 15.sp),
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
                            return  Center(
                                child:  Lottie.asset(
              'assets/Animation - 1740512569959.json',
              height: 20.h,
              fit: BoxFit.contain,
            ));
                          }
                          if (state is ParticipantsError) {
                            return Center(
                              child: Text("Error: ${state.msg}",
                                  style: Styles().msgsStyles),
                            );
                          } else if (state is ParticipantsLoaded) {
                            controller.numOfParticipants =
                                state.participants.length;
                            if (state.participants.isEmpty) {
                              return Center(
                                child: Lottie.asset(
                'assets/Animation - 1740514545687.json',
                height: 28.h,
                fit: BoxFit.contain,
              )
                              );
                            } else {
                              return ParticipantsPart(
                                controller: controller,
                                state: state.participants,
                                type: "participants",
                              );
                            }
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    AddParticipantsButton(
                      controller: controller,
                    ),
                    SizedBox(height: 2.h),
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
