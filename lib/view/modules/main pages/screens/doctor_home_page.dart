import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studify/view%20model/class/class_bloc.dart';
import 'package:studify/view%20model/class/class_event.dart';
import 'package:studify/view/modules/main%20pages/widgets/doctor_homepage_widgets.dart';
import 'package:studify/view/modules/main%20pages/widgets/homepage_appbar.dart';

class DoctorHomePage extends StatelessWidget {
  const DoctorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ClassBloc(),
        child: Builder(
          builder: (context) {
            var controller = context.read<ClassBloc>();
            controller.add(GetClassForDoctor(""));
            return Scaffold(
              appBar: const HomepageAppBar(),
              body: DoctorHomeBody(
                controller: controller,
              ),
              floatingActionButton: DoctorAddClassButton(
                controller: controller,
              ),
            );
          },
        ));
  }
}
