import 'package:dio/dio.dart';
import 'package:myapp/models/moment.dart';
import 'package:myapp/repositories/contracts/abs_api_moment_repository.dart';

import '../../core/helpers/dio_interceptor.dart';
import '../../core/resources/constants.dart';

class ApiUserDataRepository extends AbsApiMomentRepository {

  final _baseUri = '$baseUrl/api/moments';
  late Dio _dio;
  late BaseOptions _options;

  ApiUserDataRepository() {
    _options = BaseOptions(
      baseUrl: _baseUri,
    );
    _dio = Dio(_options);
    _dio.interceptors.add(DioInterceptor(dio: _dio));
  }

  @override
  Future<Moment?> create(Moment newData) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Moment>> getAll([String keyword = '']) {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Moment?> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<Moment>> getWithPagination([int page = 1, int size = 10, String keyword = '']) {
    // TODO: implement getWithPagination
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Moment updatedData) {
    // TODO: implement update
    throw UnimplementedError();
  }
}