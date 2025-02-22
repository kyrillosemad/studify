import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/core/constants/styles.dart';
import 'package:studify/view%20model/participants/participants_bloc.dart';
import 'package:studify/view/modules/class%20room/widgets/participants_part.dart';
import 'package:studify/view/shared_widgets/search_field.dart';


class StudentsDegree extends StatefulWidget {
  const StudentsDegree({super.key});

  @override
  State<StudentsDegree> createState() => _StudentsDegreeState();
}

class _StudentsDegreeState extends State<StudentsDegree> {
  var classId = Get.arguments['classId'];
  TextEditingController searchCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ParticipantsBloc>().add(FetchParticipants(classId, ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors().mainColors,
        title: const Text("Students Degrees"),
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
                  style:
                      TextStyle(fontSize: 13.sp, color: MyColors().mainColors),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              SearchField(
                  hint: "Search By Name or ID",
                  onChanged: (value) {
                    context
                        .read<ParticipantsBloc>()
                        .add(FetchParticipants(classId, value));
                  },
                  type: TextInputType.text),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: BlocBuilder<ParticipantsBloc, ParticipantsState>(
                  builder: (context, state) {
                    if (state is ParticipantsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ParticipantsLoaded) {
                      if (state.participants.isEmpty) {
                        return Center(
                          child: Text(
                            "No participants found",
                            style: Styles().msgsStyles,
                          ),
                        );
                      } else {
                        return ParticipantsPart(
                            type: "studentsDegrees",
                            classId: classId,
                            state: state.participants);
                      }
                    } else if (state is ParticipantsError) {
                      return Center(
                        child: Text(
                          "An error occurred: ${state.msg}",
                          style: TextStyle(
                              fontSize: 15.sp, color: MyColors().mainColors),
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
  }
}
