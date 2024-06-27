import 'rest_client.dart';


//TODO: implement DioClient
base class DioClient extends RestClient {
  @override
  Future<Map<String, Object?>?> delete(
    String path, {
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  }) {
    
    throw UnimplementedError();
  }

  @override
  Future<Map<String, Object?>?> get(
    String path, {
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  }) {
    
    throw UnimplementedError();
  }

  @override
  Future<Map<String, Object?>?> patch(
    String path, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  }) {
    
    throw UnimplementedError();
  }

  @override
  Future<Map<String, Object?>?> post(
    String path, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  }) {
    
    throw UnimplementedError();
  }

  @override
  Future<Map<String, Object?>?> put(
    String path, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, String?>? queryParams,
  }) {
    
    throw UnimplementedError();
  }

  

}
