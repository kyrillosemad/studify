import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:sizer/sizer.dart';

class QRCodeContainer extends StatelessWidget {
  final bool isReady;
  final String eventId;

  const QRCodeContainer({
    Key? key,
    required this.isReady,
    required this.eventId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isReady
        ? BarcodeWidget(
            data: eventId,
            barcode: Barcode.qrCode(),
            width: 100.w,
            height: 30.h,
          )
        : Container(
            width: 80.w,
            height: 35.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/qrcode_logo.png"),
              ),
            ),
          );
  }
}
