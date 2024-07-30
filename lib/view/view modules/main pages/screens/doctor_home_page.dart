import 'package:flutter/material.dart';
import 'package:studify/view%20model/class/bloc/class_bloc.dart';
import 'package:studify/view%20model/class/bloc/class_event.dart';
import 'package:studify/view/view%20modules/main%20pages/widgets/doctor_homepage_widgets.dart';
import 'package:studify/view/view%20modules/main%20pages/widgets/homepage_appbar.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  TextEditingController classNameCont = TextEditingController();
  TextEditingController classDateCont = TextEditingController();
  late ClassBloc classBloc;
  @override
  void initState() {
    super.initState();
    classBloc = ClassBloc();
    classBloc.add(GetClassForDoctor(""));
  }

@override
  void dispose() {
    classBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomepageAppBar(),
      body: DoctorHomeBody(
        classNameCont: classNameCont,
        classDateCont: classDateCont,
        classBloc: classBloc,
      ),
      floatingActionButton: DoctorAddClassButton(
        classNameCont: classNameCont,
        classDateCont: classDateCont,
      ),
    );
  }
}
