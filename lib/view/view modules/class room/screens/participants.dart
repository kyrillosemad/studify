import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view%20model/participants/bloc/participants_bloc.dart';
import 'package:studify/view/constants/styles.dart';
import 'package:studify/view/shared_widgets/search_field.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/add_participants_button.dart';
import 'package:studify/view/view%20modules/class%20room/widgets/participants_part.dart';

class Participants extends StatefulWidget {
  const Participants({super.key});

  @override
  State<Participants> createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  TextEditingController searchCont = TextEditingController();
  TextEditingController studentNameCont = TextEditingController();
  TextEditingController studentIdCont = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var classId = Get.arguments['classId'];
  int numOfParticipants = 0;

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
        centerTitle: true,
        title: BlocBuilder<ParticipantsBloc, ParticipantsState>(
          builder: (context, state) {
            if (state is ParticipantsLoaded) {
              numOfParticipants = state.participants.length;
            }
            return Text("Participants: ($numOfParticipants)");
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
                  style:
                      TextStyle(color: MyColors().mainColors, fontSize: 15.sp),
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
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is ParticipantsError) {
                      return Center(
                        child: Text("Error: ${state.msg}",
                            style: Styles().msgsStyles),
                      );
                    } else if (state is ParticipantsLoaded) {
                      numOfParticipants = state.participants.length;

                      if (state.participants.isEmpty) {
                        return Center(
                          child: Text("there's no students",
                              style: Styles().msgsStyles),
                        );
                      } else {
                        return ParticipantsPart(
                          classId: classId,
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
                  formKey: _formKey,
                  classId: classId,
                  studentIdCont: studentIdCont,
                  studentNameCont: studentNameCont),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
