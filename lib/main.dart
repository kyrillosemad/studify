import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/view%20model/class/bloc/class_bloc.dart';
import 'package:studify/view%20model/data/bloc/data_bloc.dart';
import 'package:studify/view%20model/degrees/bloc/degrees_bloc.dart';
import 'package:studify/view%20model/events/bloc/events_bloc.dart';
import 'package:studify/view%20model/participants/bloc/participants_bloc.dart';
import 'package:studify/view/constants/shared.dart';
import 'package:studify/view/view%20modules/auth/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studify/view/view%20modules/main%20pages/screens/doctor_home_page.dart';
import 'package:studify/view/view%20modules/main%20pages/screens/student_home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

SharedPreferences? userInfo;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  userInfo = await SharedPreferences.getInstance();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyC3T60AV7BE6RDCqpQLjrlNnSam5Ii4MJY",
            appId: "1:620553618045:android:148dddc06629cb94a36714",
            messagingSenderId: "620553618045",
            projectId: "studify-59b93",
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ParticipantsBloc(),
            ),
            BlocProvider(
              create: (context) => ClassBloc(),
            ),
            BlocProvider(
              create: (context) => EventsBloc(),
            ),
            BlocProvider(
              create: (context) => DegreesBloc(),
            ),
            BlocProvider(
              create: (context) => DataBloc(),
            ),
          ],
          child: GetMaterialApp(
            home: Shared().id == null
                ? const Login()
                : Shared().type == "doctor"
                    ? const DoctorHomePage()
                    : const StudentHomePage(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
