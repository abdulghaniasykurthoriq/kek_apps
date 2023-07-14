import 'dart:convert';
// import 'dart:io';

import 'package:kek_app/constant.dart';
import 'package:kek_app/models/api_response.dart';
import 'package:kek_app/models/riwayat_patient.dart';
import 'package:kek_app/services/user_services.dart';
import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

Future<ApiResponse> retrieveRiwayatPatients(String name, int page) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http
        .get(Uri.parse('$riwayatURL?name=$name&page=$page'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => RiwayatPatient.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
        apiResponse.currentPage = jsonDecode(response.body)['current_page'];
        apiResponse.lastPage = jsonDecode(response.body)['last_page'];
        apiResponse.totalItems = jsonDecode(response.body)['total'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> retrieveRiwayatMyPatients() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(riwayatMyPatientURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data']
            .map<RiwayatPatient>((p) => RiwayatPatient.fromJson(p))
            .toList();
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    // print(e);
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> createRiwayatPasient(String status, int patientId,
    String resultDiagnosis, String additionalFood, String healthyFood) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(riwayatURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'status': status,
      'patient_id': patientId.toString(), // Konversi patientId ke String
      'result_diagnosis': resultDiagnosis,
      'additional_food': additionalFood, // Perbaikan penulisan nama properti
      'healthy_food': healthyFood
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.first][0];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = somethingWentWrong;
  }

  return apiResponse;
}

Future<ApiResponse> deleteRiwayatPatient(int riwayatId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();

    final response = await http.delete(Uri.parse('$riwayatURL/$riwayatId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> getTotalRiwayatPatiet() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse('$riwayatURL/total'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}




// Future<ApiResponse> downloadRiwayatPatientPdf() async {
//   ApiResponse apiResponse = ApiResponse();

//   try {
//     String token = await getToken();
//     final response = await http.get(Uri.parse(riwayatPatientURLDownload),
//         headers: {
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token'
//         });
//     switch (response.statusCode) {
//       case 200:
//         apiResponse.data = jsonDecode(response.body)['data']
//             .map((p) => RiwayatPatient.fromJson(p))
//             .toList();
//         apiResponse.data as List<dynamic>;
//         break;
//       case 401:
//         apiResponse.error = unauthorized;
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//     }
//   } catch (e) {
//     apiResponse.error = serverError;
//   }

//   return apiResponse;
// }

// import 'package:http/http.dart' as http;
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:kek_app/constant.dart';
// import 'package:kek_app/models/api_response.dart';

// Future<ApiResponse> downloadRiwayatPatientPdf() async {
//   ApiResponse apiResponse = ApiResponse();

//   try {
//     String token = await getToken();
//     final response = await http.get(Uri.parse(riwayatPatientURLDownload),
//         headers: {
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token'
//         });
//     switch (response.statusCode) {
//       case 200:
//         Directory? appDocDir = await getExternalStorageDirectory();
//         String filePath = '${appDocDir!.path}/riwayat_presiden.pdf';
//         // String filePath = 'Download/riwayat_presiden.pdf';

//         // Meminta izin penyimpanan
//         var status = await Permission.storage.request();
//         if (status.isGranted || status.isLimited) {
//           // Menulis data PDF ke file
//           File pdfFile = File(filePath);
//           await pdfFile.writeAsBytes(response.bodyBytes);

//           apiResponse.data = filePath;
//         } else {
//           apiResponse.error = 'Permission denied to access storage.';
//         }
//         break;
//       case 401:
//         apiResponse.error = unauthorized;
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//     }
//   } catch (e) {
//     apiResponse.error = serverError;
//   }

//   return apiResponse;
// }

// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'dart:io';
// import 'package:kek_app/constant.dart';
// import 'package:kek_app/models/api_response.dart';
// import 'package:http/http.dart' as http;

// Future<ApiResponse> downloadRiwayatPatientPdf() async {
//   ApiResponse apiResponse = ApiResponse();

//   try {
//     String token = await getToken();
//     final response = await http.get(Uri.parse(riwayatPatientURLDownload),
//         headers: {
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token'
//         });
//     switch (response.statusCode) {
//       case 200:
//         Directory? appDocDir = await getExternalStorageDirectory();
//         String downloadPath = '${appDocDir!.path}/Download';
//         String filePath = '$downloadPath/riwayat_presiden.pdf';

//         // Meminta izin penyimpanan
//         var status = await Permission.storage.request();
//         if (status.isGranted || status.isLimited) {
//           // Membuat folder "Download" jika belum ada
//           Directory(downloadPath).createSync(recursive: true);

//           // Menulis data PDF ke file
//           File pdfFile = File(filePath);
//           await pdfFile.writeAsBytes(response.bodyBytes);

//           apiResponse.data = filePath;
//         } else {
//           apiResponse.error = 'Permission denied to access storage.';
//         }
//         break;
//       case 401:
//         apiResponse.error = unauthorized;
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//     }
//   } catch (e) {
//     apiResponse.error = serverError;
//   }

//   return apiResponse;
// }
