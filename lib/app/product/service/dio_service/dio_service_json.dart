import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../service_settings.dart';



final class DioServiceJson {
  DioServiceJson() {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  final String baseUrl = ServiceSettings.baseUrl;

  late final Dio _dio;

  Future<dynamic> get(
      String path, {
        Object? data,
        bool addToken = false,
        Map<String, dynamic>? header,
        Map<String, dynamic>? queryParams,
      }) async {
    _addInterceptor(addToken: addToken);
    _setUnsafeHttpClient();
    try {
      final response = await _dio.get<dynamic>(
        path,
        data: data,
        options: Options(headers: header),
        queryParameters: queryParams,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
      return null;
    } on DioException catch (e) {
      return _handleDioException(e);
    }
  }

  Future<dynamic> post(
      String path, {
        Object? data,
        bool addToken = false,
        Map<String, dynamic>? header,
      }) async {
    _addInterceptor(addToken: addToken);
    _setUnsafeHttpClient();
    try {
      final response = await _dio.post<dynamic>(
        path,
        data: data,
        options: Options(headers: header),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
      return null;
    } on DioException catch (e) {
      return _handleDioException(e);
    }
  }

  Future<dynamic> delete(
      String path, {
        Object? data,
        bool addToken = false,
      }) async {
    _addInterceptor(addToken: addToken);
    _setUnsafeHttpClient();
    try {
      final response = await _dio.delete<dynamic>(path, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
      return null;
    } on DioException catch (e) {
      return _handleDioException(e);
    }
  }

  Future<dynamic> put(
      String path, {
        Object? data,
        bool addToken = false,
      }) async {
    _addInterceptor(addToken: addToken);
    _setUnsafeHttpClient();
    try {
      final response = await _dio.put<dynamic>(path, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
      return null;
    } on DioException catch (e) {
      return _handleDioException(e);
    }
  }

  Future<File?> download({
    required String url,
    required String filePath,
  }) async {
    try {
      final file = File(filePath);
      final response = await _dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print('İndirme %: ${(received / total * 100).toStringAsFixed(0)}');
          }
        },
      );
      if (response.statusCode == 200) {
        return file;
      } else {
        print('İndirme başarısız: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('İndirme hatası: $e');
      return null;
    }
  }

  void _setUnsafeHttpClient() {
    _dio.httpClientAdapter = IOHttpClientAdapter(
      validateCertificate: (X509Certificate? cert, String host, int port) => true,
      createHttpClient: () {
        return HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
      },
    );
  }

  void _addInterceptor({bool addToken = false, String? token, bool addApiKeyHeader = false, String? apiKey}) {
    _dio.interceptors.clear();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (addToken && token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          if (addApiKeyHeader && apiKey != null && apiKey.isNotEmpty) {
            options.headers['x-api-key'] = apiKey;
          }
          return handler.next(options);
        },
        onError: (error, handler) => handler.next(error),
        onResponse: (response, handler) => handler.next(response),
      ),
    );
  }

  dynamic _handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionError) {
      return 'Lütfen internet bağlantınızı kontrol ediniz.'; // hata mesajı dönebilir
    } else {
      return null;
    }
  }
}
