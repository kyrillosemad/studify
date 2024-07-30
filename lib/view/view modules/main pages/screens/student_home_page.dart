import 'package:flutter/material.dart';
import 'package:studify/view%20model/class/bloc/class_bloc.dart';
import 'package:studify/view%20model/class/bloc/class_event.dart';
import 'package:studify/view/view%20modules/main%20pages/widgets/homepage_appbar.dart';
import 'package:studify/view/view%20modules/main%20pages/widgets/student_homepage_widgets.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  TextEditingController classId = TextEditingController();
  TextEditingController searchController = TextEditingController();
  late ClassBloc classBloc;

  @override
  void initState() {
    super.initState();
    classBloc = ClassBloc();
    classBloc.add(GetClassForStudent(""));
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
      body: StudentHomeBody(
        classBloc: classBloc,
        classIdController: classId,
        searchController: searchController,
      ),
      floatingActionButton: AddClassButton(
        classIdController: classId,
      ),
    );
  }
}
