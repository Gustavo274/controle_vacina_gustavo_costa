import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart';
import 'interceptor/logging_interceptor.dart';

final Client client =
    InterceptedClient.build(interceptors: [LoggingInterceptor()]);
const String baseUrl = '192.168.1.66:8080';
const String api = 'api/v1/vacinas';
