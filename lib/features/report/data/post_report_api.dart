// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:lawbug829/helpers/toast.dart';
// import 'package:lawbug829/networks/dio/dio.dart';
// import 'package:lawbug829/networks/endpoints.dart';
// import 'package:lawbug829/networks/exception_handler/data_source.dart';

// final class PostExpenseApi {
//   static final PostExpenseApi _singleton = PostExpenseApi._internal();

//   PostExpenseApi._internal();

//   static PostExpenseApi get instance => _singleton;

//   Future<Map<String, dynamic>> postExpenseApi({
//     required dynamic amount_spent,
//     required dynamic date,
//     required dynamic category,
//     required dynamic payment_method,
//     required dynamic location,
//     required dynamic description,
//     required dynamic file,
//   }) async {
//     try {
//       // * Create the request data map
//       Map<String, dynamic> data = {
//         'amount_spent': amount_spent,
//         'date': date,
//         'category': category,
//         'payment_method': payment_method,
//         'location': location,
//         'description': description,
//         'file': file, // Assuming file is already in the correct format
//       };

//       // * Make the POST request
//       Response response = (await postHttp(Endpoints.postExpense(), data));

//       if (response.statusCode == 200) {
//         final data = json.decode(json.encode(response.data));
//         ToastUtil.showShortToast('Complain Send Successfully');
//         return data;
//       } else {
//         throw DataSource.DEFAULT.getFailure();
//       }
//     } catch (error) {
//       print("Error during sending: $error");
//       rethrow;
//     }
//   }
// }

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lawbug829/helpers/toast.dart';
import 'package:lawbug829/networks/dio/dio.dart';
import 'package:lawbug829/networks/endpoints.dart';
import 'package:lawbug829/helpers/dio_helper.dart';
import 'package:image_picker/image_picker.dart';

final class PostExpenseApi {
  static final PostExpenseApi _singleton = PostExpenseApi._internal();

  PostExpenseApi._internal();

  static PostExpenseApi get instance => _singleton;

  Future<Map<String, dynamic>> postExpenseApi({
    required dynamic amount_spent,
    required dynamic date,
    required dynamic category,
    required dynamic payment_method,
    required dynamic location,
    required dynamic description,
    required dynamic file, // Expecting a File or path to the file
  }) async {
    try {
      // * Create FormData for multipart request
      FormData formData = FormData.fromMap({
        'amount_spent': amount_spent,
        'date': date,
        'category': category,
        'payment_method': payment_method,
        'location': location,
        'description': description,
        'file': await getMultipartFile(file), // Convert file to MultipartFile
      });

      // * Make the POST request with multipart/form-data
      Response response = await postHttp(Endpoints.postExpense(), formData);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));
        ToastUtil.showShortToast('Complain Send Successfully');
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      print("Error during sending: $error");
      rethrow;
    }
  }
}
