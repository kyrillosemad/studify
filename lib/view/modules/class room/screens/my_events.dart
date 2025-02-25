// my_events.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/core/constants/styles.dart';
import 'package:studify/view%20model/my_events/my_events_bloc.dart';
import 'package:studify/view/modules/class%20room/widgets/events_part.dart';
import 'package:studify/view/shared_widgets/search_field.dart';

class MyEvents extends StatelessWidget {
  const MyEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MyEventsBloc(),
        child: Builder(
          builder: (context) {
            var controller = context.read<MyEventsBloc>();
            controller.add(GetEvents(controller.classId, ''));
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
                          style: TextStyle(
                              fontSize: 13.sp, color: MyColors().mainColors),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SearchField(
                          hint: "Search",
                          onChanged: (value) {
                            controller.add(GetEvents(
                                controller.classId, value.toString()));
                          },
                          type: TextInputType.text),
                      SizedBox(
                        height: 2.h,
                      ),
                      Expanded(child: BlocBuilder<MyEventsBloc, MyEventsState>(
                        builder: (context, state) {
                          if (state is MYEventsLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is MyEventsError) {
                            return Center(
                              child: Text(
                                "Something Wrong ${state.msg}",
                                style: Styles().msgsStyles,
                              ),
                            );
                          }
                          if (state is MyEventsLoaded) {
                            if (state.events.isEmpty) {
                              return Center(
                                child: Text(
                                  "There's no events",
                                  style: Styles().msgsStyles,
                                ),
                              );
                            }
                            return EventsPart(
                                controller: controller,
                                classId: controller.classId,
                                state: state.events);
                          }
                          return const SizedBox.shrink();
                        },
                      ))
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
