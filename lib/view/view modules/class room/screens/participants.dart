import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:studify/view%20model/participants/bloc/participants_bloc.dart';
import 'package:studify/view/constants/styles.dart';

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
              TextFormField(
                controller: searchCont,
                style: TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: MyColors().mainColors),
                  hintText: "Search by Name or ID",
                  hintStyle:
                      TextStyle(fontSize: 15.sp, color: MyColors().mainColors),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                  ),
                ),
                onChanged: (value) {
                  context
                      .read<ParticipantsBloc>()
                      .add(FetchParticipants(classId, value));
                },
              ),
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
                        return ListView.builder(
                          itemCount: state.participants.length,
                          itemBuilder: (context, index) {
                            var classData = state.participants[index];
                            return Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: MyColors().mainColors,
                                    offset: const Offset(0, 0),
                                    blurRadius: 5,
                                    blurStyle: BlurStyle.outer,
                                    spreadRadius: 1,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              margin: EdgeInsets.all(5.sp),
                              height: 9.h,
                              child: ListTile(
                                leading: Icon(Icons.person,
                                    color: MyColors().mainColors),
                                title: Text(
                                  classData['studentName'],
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: MyColors().mainColors),
                                ),
                                trailing: InkWell(
                                  onTap: () {
                                    Get.defaultDialog(
                                      buttonColor: MyColors().mainColors,
                                      cancelTextColor: MyColors().mainColors,
                                      confirmTextColor: Colors.white,
                                      title: "Delete?",
                                      titleStyle: TextStyle(
                                          color: MyColors().mainColors),
                                      content: Text(
                                        "delete this participants",
                                        style: TextStyle(
                                            color: MyColors().mainColors),
                                      ),
                                      onCancel: () {},
                                      onConfirm: () {
                                        context.read<ParticipantsBloc>().add(
                                              DeleteParticipants(
                                                  classId,
                                                  classData['studentName'],
                                                  classData['studentId']),
                                            );
                                      },
                                    );
                                  },
                                  child: Icon(Icons.delete,
                                      size: 25.sp,
                                      color: MyColors().mainColors),
                                ),
                                subtitle: Text(
                                  "ID: ${classData['studentId']}",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: MyColors().mainColors),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Get.defaultDialog(
                      buttonColor: MyColors().mainColors,
                      cancelTextColor: MyColors().mainColors,
                      confirmTextColor: Colors.white,
                      onCancel: () {},
                      onConfirm: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ParticipantsBloc>().add(
                                AddParticipants(
                                  classId,
                                  studentIdCont.text,
                                  studentNameCont.text,
                                ),
                              );
                          studentIdCont.clear();
                          studentNameCont.clear();
                          Get.back();
                        }
                      },
                      title: "New participant",
                      titleStyle: TextStyle(color: MyColors().mainColors),
                      content: Form(
                        key: _formKey,
                        child: SizedBox(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: studentNameCont,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.abc),
                                  focusedBorder: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(),
                                  hintText: "Student Name",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the student name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 1.h),
                              TextFormField(
                                controller: studentIdCont,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.perm_identity),
                                  focusedBorder: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(),
                                  hintText: "Student ID",
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the student ID';
                                  }
                                  final int? id = int.tryParse(value);
                                  if (id == null || id <= 0) {
                                    return 'Student ID must be a positive number';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                      color: Colors.green,
                    ),
                    width: 85.w,
                    height: 7.h,
                    child: Center(
                      child: Text(
                        "Add new participant",
                        style: TextStyle(fontSize: 13.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
