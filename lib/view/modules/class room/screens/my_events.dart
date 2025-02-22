// my_events.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/core/constants/styles.dart';
import 'package:studify/view%20model/events/events_bloc.dart';
import 'package:studify/view/modules/class%20room/widgets/events_part.dart';
import 'package:studify/view/shared_widgets/search_field.dart';


class MyEvents extends StatefulWidget {
  const MyEvents({super.key});

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  TextEditingController searchCont = TextEditingController();
  var classId = Get.arguments['classId'];
  @override
  void initState() {
    super.initState();
    context.read<EventsBloc>().add(GetEvents(classId, ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors().mainColors,
        title: const Text("My Events"),
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
                child: Text(
                  "You can find here all events you add to this class",
                  style:
                      TextStyle(fontSize: 13.sp, color: MyColors().mainColors),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              SearchField(
                  hint: "Search",
                  onChanged: (value) {
                    context.read<EventsBloc>().add(GetEvents(classId, value));
                  },
                  type: TextInputType.text),
              SizedBox(
                height: 2.h,
              ),
              Expanded(child: BlocBuilder<EventsBloc, EventsState>(
                builder: (context, state) {
                  if (state is EventsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is EventsError) {
                    return Center(
                      child: Text(
                        "Something Wrong ${state.msg}",
                        style: Styles().msgsStyles,
                      ),
                    );
                  }
                  if (state is EventsLoaded) {
                    if (state.events.isEmpty) {
                      return Center(
                        child: Text(
                          "There's no events",
                          style: Styles().msgsStyles,
                        ),
                      );
                    }
                    return EventsPart(classId: classId, state: state.events);
                  }
                  return const SizedBox.shrink();
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
