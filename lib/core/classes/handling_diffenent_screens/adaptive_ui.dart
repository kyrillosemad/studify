// import 'package:flutter/material.dart';

// // ويمكنك استخدام ايضا
// // sizer package or utilsize package
// class AdaptiveUiClass {
//   // دالة للحصول على نوع الجهاز (موبايل، تابلت، ديسكتوب)
//   static String getDeviceType(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     if (width < 600) {
//       return 'mobile';
//     } else if (width >= 600 && width < 1200) {
//       return 'tablet';
//     } else {
//       return 'desktop';
//     }
//   }

// //ضبط عرض شي معين بناء علي نوع الجهاز
//   static double getResponsiveWidth(BuildContext context, double mobileWidth,
//       {double? tabletWidth, double? desktopWidth}) {
//     String deviceType = getDeviceType(context);
//     switch (deviceType) {
//       case 'mobile':
//         return mobileWidth;
//       case 'tablet':
//         return tabletWidth ?? mobileWidth;
//       case 'desktop':
//         return desktopWidth ?? tabletWidth ?? mobileWidth;
//       default:
//         return mobileWidth;
//     }
//   }

// //ضبط ارتفاع شي معين بناء علي نوع الجهاز
//   static double getResponsiveHeight(BuildContext context, double mobileHeight,
//       {double? tabletHeight, double? desktopHeight}) {
//     String deviceType = getDeviceType(context);
//     switch (deviceType) {
//       case 'mobile':
//         return mobileHeight;
//       case 'tablet':
//         return tabletHeight ?? mobileHeight;
//       case 'desktop':
//         return desktopHeight ?? tabletHeight ?? mobileHeight;
//       default:
//         return mobileHeight;
//     }
//   }

// //ضبط خط شي معين بناء علي نوع الجهاز
//   static double getResponsiveTextSize(BuildContext context, double mobileSize,
//       {double? tabletSize, double? desktopSize}) {
//     String deviceType = getDeviceType(context);
//     switch (deviceType) {
//       case 'mobile':
//         return mobileSize;
//       case 'tablet':
//         return tabletSize ?? mobileSize;
//       case 'desktop':
//         return desktopSize ?? tabletSize ?? mobileSize;
//       default:
//         return mobileSize;
//     }
//   }

//   //دالة لضبط جزء من اليو اي بناء علي نوع الجهاز
//   //معاك ايضا الطول والعرض للجزء اللي انت محاوط عليه من خلال constraints
//   // اذن انت كده تقدر تنبي شكل متجاوب علي اجهزة مختلفة النوع او حتي نفس النوع ولكن مختلفة المقاس
//   static Widget adaptiveLayout({
//     required BuildContext context,
//     required Widget Function(BuildContext context, BoxConstraints constraints)
//         mobileLayout,
//     required Widget Function(BuildContext context, BoxConstraints constraints)
//         tabletLayout,
//     required Widget Function(BuildContext context, BoxConstraints constraints)
//         desktopLayout,
//   }) {
//     String deviceType = getDeviceType(context);

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         if (deviceType == 'mobile') {
//           return mobileLayout(context, constraints);
//         } else if (deviceType == 'tablet') {
//           return tabletLayout(context, constraints);
//         } else {
//           return desktopLayout(context, constraints);
//         }
//       },
//     );
//   }

//   //دالة لضبط جزء من اليو اي بناء علي وضعية الجهاز
//   static Widget adaptiveOrientation({
//     required BuildContext context,
//     required Widget portraitLayout,
//     required Widget landscapeLayout,
//   }) {
//     return OrientationBuilder(
//       builder: (context, orientation) {
//         if (orientation == Orientation.portrait) {
//           return portraitLayout;
//         } else {
//           return landscapeLayout;
//         }
//       },
//     );
//   }

//   //دالة لضبط جزء من اليو اي بناء علي نوع نظام التشغيل
//   static Widget adaptivePlatform({
//     required BuildContext context,
//     required Widget Function(BuildContext context) iOSLayout,
//     required Widget Function(BuildContext context) androidLayout,
//     required Widget Function(BuildContext context) webLayout,
//   }) {
//     // تحديد النظام التشغيلي
//     if (Theme.of(context).platform == TargetPlatform.iOS) {
//       return iOSLayout(context);
//     } else if (Theme.of(context).platform == TargetPlatform.android) {
//       return androidLayout(context);
//     } else {
//       return webLayout(context);
//     }
//   }
// }
