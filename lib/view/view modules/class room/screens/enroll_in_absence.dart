import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/data/firebase/class/enroll_in_absence.dart';
import 'package:studify/view/constants/colors.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:studify/view/constants/shared.dart';

class EnrollInAbsence extends StatefulWidget {
  const EnrollInAbsence({super.key});

  @override
  State<EnrollInAbsence> createState() => _EnrollInAbsenceState();
}

class _EnrollInAbsenceState extends State<EnrollInAbsence> {
  var classId = Get.arguments['classId'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors().mainColors,
        title: const Text("Enroll In absence"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Center(
          child: InkWell(
            onTap: () async {
              FlutterBarcodeScanner.scanBarcode(
                      "#2A99CF", "cancel", true, ScanMode.QR)
                  .then((value) {
                print("//////////////////////////////////////////// $value");
                enrollInAbsence(classId, value.toString(),
                    Shared().userName.toString(), Shared().id.toString());
              });
            },
            child: Container(
              width: 90.w,
              height: 6.h,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.sp)),
              child: Center(
                child: Text(
                  "Enroll in the absence",
                  style: TextStyle(fontSize: 13.sp, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
