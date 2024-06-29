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
      final response = await dio.put(
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

  /// Request body
  /// ```json
  /// {
  /// "list": [
  ///     {
  ///         "color": "<hex color>",
  ///         "importance": <"low"|"basic"|"important">,
  ///         "done": <bool>,
  ///         "created_at": <timestamp>,
  ///         "id": "<uuid>",
  ///         "text": "some text",
  ///         "changed_at": <timestamp>,
  ///         "deadline": <timestamp>,
  ///         "last_updated_by": "123"
  ///     },
  ///     ...
  /// ]
  /// }
  /// ```
  ///
  /// header
  /// ```
  /// "X-Last-Known-Revision": <current revision>
  /// ```
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

  /// Request body
  /// ```json
  /// {
  ///    "element": {
  ///         "color": "<hex color>",
  ///         "importance": <"low"|"basic"|"important">,
  ///         "done": <bool>,
  ///         "created_at": <timestamp>,
  ///         "id": "<uuid>",
  ///         "text": "some text",
  ///         "changed_at": <timestamp>,
  ///         "deadline": <timestamp>,
  ///         "last_updated_by": "123"
  ///     }
  /// }
  /// ```
  ///
  /// Header
  /// ```
  /// "X-Last-Known-Revision": <current revision>
  /// ```
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

  /// Request body
  /// ```json
  /// {
  ///    "element": {
  ///         "color": "<hex color>",
  ///         "importance": <"low"|"basic"|"important">,
  ///         "done": <bool>,
  ///         "created_at": <timestamp>,
  ///         "id": "<uuid>",
  ///         "text": "some text",
  ///         "changed_at": <timestamp>,
  ///         "deadline": <timestamp>,
  ///         "last_updated_by": "123"
  ///     }
  /// }
  /// ```
  ///
  /// Header
  /// ```
  /// "X-Last-Known-Revision": <current revision>
  /// ```
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
