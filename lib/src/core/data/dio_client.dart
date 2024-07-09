import 'package:dio/dio.dart';

import 'rest_client.dart';

base class DioClient extends RestClient {
  final Dio dio;

  DioClient({required this.dio});

  @override
  Future<Map<String, Object?>?> deleteTodo(
    String path,
    String uuid, {
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  }) async {
    try {
      final response = await dio.delete(
        '$path/$uuid',
        options: Options(headers: headers),
      );

      final data = response.data;

      return data;
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
  }

  @override
  Future<Map<String, Object?>?> getList(
    String path, {
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  }) async {
    try {
      final response = await dio.get(path);

      final data = response.data;

      return data;
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
  }

  @override
  Future<Map<String, Object?>?> getTodo(
    String path,
    String uuid, {
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  }) async {
    try {
      final response = await dio.get('$path/$uuid');

      final data = response.data;

      return data;
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
  }


  @override
  Future<Map<String, Object?>?> updateList(
    String path, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: body,
        options: Options(headers: headers),
      );

      final data = response.data;

      return data;
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
  }


  @override
  Future<Map<String, Object?>?> addTodo(
    String path, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: body,
        options: Options(headers: headers),
      );

      final data = response.data;

      return data;
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
  }


  @override
  Future<Map<String, Object?>?> changeTodo(
    String path,
    String uuid, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  }) async {
    try {
      final response = await dio.put(
        '$path/$uuid',
        data: body,
        options: Options(headers: headers),
      );

      final data = response.data;

      return data;
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
  }
}
