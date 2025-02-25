import 'package:flutter/material.dart';
import 'package:studify/core/constants/routes_name.dart';
import 'package:studify/view/modules/auth/screens/login.dart';
import 'package:studify/view/modules/auth/screens/signup.dart';
import 'package:studify/view/modules/class%20room/screens/one_student_degree.dart';
import 'package:studify/view/modules/class%20room/screens/participants.dart';
import 'package:studify/view/modules/class%20room/screens/students_degrees.dart';
import 'package:studify/view/modules/main%20pages/screens/doctor_class_room.dart';
import 'package:studify/view/modules/main%20pages/screens/doctor_home_page.dart';
import 'package:studify/view/modules/main%20pages/screens/student_class_room.dart';
import 'package:studify/view/modules/main%20pages/screens/student_home_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes().login: (context) => const LoginPage(),
  AppRoutes().signUp: (context) => const SignUpPage(),
  AppRoutes().studentClassRoom: (context) => const StudentClassRoom(),
  AppRoutes().studentHomePage: (context) => const StudentHomePage(),
  AppRoutes().doctorClassRoom: (context) => const DoctorClassRoom(),
  AppRoutes().doctorHomePage: (context) => const DoctorHomePage(),
  AppRoutes().studentsDegrees: (context) => const StudentsDegree(),
  AppRoutes().oneStudentDegree: (context) => const OneStudentDegree(),
  AppRoutes().participants: (context) => const Participants(),
};
