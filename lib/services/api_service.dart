import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/task.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/todos")
  Future<List<Task>> getTasks();
}
