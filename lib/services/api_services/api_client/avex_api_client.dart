import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/models.dart';
import '../../dio_provider.dart';

part "avex_api_client.g.dart";

@RestApi(baseUrl: "https://auth.devdeg.com")
abstract class AvexApiClient {
  factory AvexApiClient(Dio dio) = _AvexApiClient;

  @POST("/auth/login")
  Future<HttpResponse> generateEmailDynamicLink(@Body() SignupRequest request);

  @POST("/auth/verify/{authToken}")
  Future<HttpResponse> verifyAuthToken(
    @Path() String authToken,
  );

  @GET("/user/exists")
  Future<HttpResponse> getUserExistence(
    @Header("Authorization") String accessToken,
  );
}
