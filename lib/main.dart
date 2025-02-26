import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/routes.dart';
import 'package:studify/core/constants/shared.dart';
import 'package:studify/core/services/services.dart';
import 'package:studify/view%20model/my_events/my_events_bloc.dart';
import 'package:studify/view%20model/one_event_bloc/one_event_bloc.dart';
import 'package:studify/view%20model/participants/participants_bloc.dart';
import 'package:studify/view/modules/auth/screens/login.dart';
import 'package:studify/view/modules/main%20pages/screens/doctor_home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'view/modules/main pages/screens/student_home_page.dart';

void main() async {
  final services = Get.put(Services());
  services.init();
  WidgetsFlutterBinding.ensureInitialized();
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
              create: (context) => OneEventBloc(),
            ),
            BlocProvider(
              create: (context) => MyEventsBloc(),
            ),
            BlocProvider(
              create: (context) => ParticipantsBloc(),
            ),
          ],
          child: GetMaterialApp(
            routes: routes,
            home: Shared().id == null
                ? const LoginPage()
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
