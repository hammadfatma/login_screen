import 'package:dio/dio.dart';
import 'package:loginscreen/models/user.dart';

class DioHelper {
  final String _baseUrl = 'https://dummyjson.com';
  final Dio _dio;
  DioHelper(this._dio);
  Future<Map<String, dynamic>?> loginUser(
      String userName, String password) async {
    var response = await _dio.post(
      '$_baseUrl/auth/login',
      data: {
        'username': userName,
        'password': password,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> addUser(User userModel) async {
    var response = await _dio.post(
      '$_baseUrl/users/add',
      data: {
        'email': userModel.email,
        'username': userModel.username,
        'password': userModel.password,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return response.data;
  }
}
