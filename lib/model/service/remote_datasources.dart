import 'package:dio/dio.dart';
import 'package:suitmedia_test/view_model/models/user.dart';

abstract class RemoteDataSource {
  Future<ListUser> getListUser(int page);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  static const String _baseURL = 'https://reqres.in';

  @override
  Future<ListUser> getListUser(int page) async {
    try {
      final response = await Dio().get(
        '$_baseURL/api/users?page=$page&per_page=10',
        options: Options(headers: {
          "Accept": "application/json",
        }),
      );
      return ListUser.fromJson(response.data);
    } on DioException catch (e) {
      return ListUser.fromJson(e.response?.data);
    }
  }
}
