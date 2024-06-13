
import 'package:attendance/models/dto/response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

int getTimestamp() {
  // Use DateTime.now() to get the current time
  var now = DateTime.now();
  // Use millisecondsSinceEpoch property to get the timestamp in milliseconds
  return now.millisecondsSinceEpoch;
}

class AuthService {
  final String baseUrl;
  final Dio dio;

  // AuthService(this.baseUrl) : dio = Dio(BaseOptions(baseUrl: baseUrl));
  AuthService(this.baseUrl)
      : dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(milliseconds: 3000),
        )) {
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<LoginResponse> login(LoginData loginData) async {
    int timestamp = getTimestamp();
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    try {
      // final response = await dio.post('/login?timestamp=$timeStamp', data: loginData);
      final response = await dio.post(
        '/api/login?timestamp=$timestamp', // Adjust the endpoint as necessary
        data: {
          'email': loginData.email,
          'password': loginData.password,
          'remember': loginData.remember ?? false
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Credentials': 'true',
            'Authorization' : "Bearer $token",
          },
        ),
      );

      return LoginResponse.fromJson(response.data);
    } on DioError catch (e) {
      // Handle Dio errors
      if (e.response != null) {
        print('Failed to login. Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
        // Return a LoginResponse with the error message
        return LoginResponse(
            success: false, message: e.response?.data['message']);
      } else {
        print('Unexpected error: $e');
        throw Exception('Unexpected error: $e');
      }
    }
  }

//   Future<LoginResponse> login(LoginData loginData) async {
//     try {
//       final response = await dio.post(
//         '/login', // Adjust the endpoint as necessary
//         data: {
//           'email': loginData.email,
//           'password': loginData.password,
//         },
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//           },
//         ),
//       );
//
//       // Assuming the response is a JSON map
//       return LoginResponse.fromJson(response.data);
//     } on DioError catch (e) {
//       // Handle Dio errors
//       if (e.response != null) {
//         print('Failed to login. Status code: ${e.response?.statusCode}');
//         throw Exception('Failed to login. Status code: ${e.response?.statusCode}');
//       } else {
//         print('Unexpected error: $e');
//         throw Exception('Unexpected error: $e');
//       }
//   }
// }

  // Future<LoginResponse> login(LoginData loginData) async {
  //   var timeStamp = DateTime.timestamp();
  //   final response = await dio.post('login?timestamp=$timeStamp', data: loginData);
  //   //     print("+++++++Resp : ${response.data}");
  //   // Simulating an API call
  //   // You should replace this with actual API call code
  //   final result = await Future.delayed(
  //     const Duration(seconds: 2),
  //         () => {
  //       "success": false,
  //       "result": null,
  //       "message": "No account with this email has been registered."
  //     },
  //   );
  //
  //   // Assuming the response is a JSON map
  //   return LoginResponse.fromJson(response.data);
  // }

// Add other methods for register, verify, reset password, logout, etc.
}
