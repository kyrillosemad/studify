import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studify/view%20model/class/class_bloc.dart';
import 'package:studify/view%20model/class/class_event.dart';
import 'package:studify/view/modules/main%20pages/widgets/homepage_appbar.dart';
import 'package:studify/view/modules/main%20pages/widgets/student_homepage_widgets.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ClassBloc(),
        child: Builder(
          builder: (context) {
            var controller = context.read<ClassBloc>();
            controller.add(GetClassForStudent(""));
            return Scaffold(
              appBar: const HomepageAppBar(),
              body: StudentHomeBody(
                controller: controller,
              ),
              floatingActionButton: AddClassButton(
                controller: controller,
              ),
            );
          },
        ));
  }
}
