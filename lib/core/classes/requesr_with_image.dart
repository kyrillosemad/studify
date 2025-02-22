// import 'dart:convert';
// import 'dart:io';
// import 'package:dartz/dartz.dart';
// import 'package:http/http.dart' as http;
// import 'package:jawla/core/classes/status.dart';
// import 'package:jawla/core/functions/check_internet.dart';

// class Request {
//   Future<Either<Status, Map>> requestWithImage(
//       String link, Map<String, String> data, File? imageFile) async {
//     try {
//       if (await checkInternet()) {
//         var request = http.MultipartRequest('POST', Uri.parse(link));

//         data.forEach((key, value) {
//           request.fields[key] = value;
//         });

//         if (imageFile != null) {
//           var image = await http.MultipartFile.fromPath(
//             'image', // المفتاح الذي سيستخدمه الـ backend لاستقبال الصورة
//             imageFile.path,
//           );
//           request.files.add(image);
//         }

//         var streamedResponse = await request.send();

//         var response = await http.Response.fromStream(streamedResponse);

//         if (response.statusCode == 200 || response.statusCode == 201) {
//           var responseData = jsonDecode(response.body);
//           return right(responseData);
//         } else {
//           return left(Status.serverFailure);
//         }
//       } else {
//         return left(Status.internetFailure);
//       }
//     } catch (e) {
//       return left(Status.serverFailure);
//     }
//   }
// }
