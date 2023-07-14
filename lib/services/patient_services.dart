import 'dart:convert';

import 'package:kek_app/constant.dart';
import 'package:kek_app/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:kek_app/models/patient.dart';
import 'package:kek_app/services/user_services.dart';

Future<ApiResponse> getPatients(String q, int page) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse('$patientURL?q=$q&page=$page'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    // print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        // final responseData = jsonDecode(response.body);
        // print(responseData['data']);
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => Patient.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
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

Future<ApiResponse> createPatient(
    String name, String alamat, int tinggiBadan, DateTime tanggalLahir) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(patientURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'name': name,
      'alamat': alamat,
      'tanggal_lahir': tanggalLahir.toString(),
      'tinggi_badan': tinggiBadan.toString(),
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
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> editPatient(int patientId, String name, String alamat,
    int tinggiBadan, DateTime tanggalLahir) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response =
        await http.put(Uri.parse('$patientURL/$patientId'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'name': name,
      'alamat': alamat,
      'tanggal_lahir': tanggalLahir.toString(),
      'tinggi_badan': tinggiBadan.toString(),
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
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> deletePatient(int patientId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.delete(Uri.parse('$patientURL/$patientId'),
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
