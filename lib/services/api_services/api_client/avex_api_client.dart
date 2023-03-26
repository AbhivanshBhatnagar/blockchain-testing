import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/models/requests/refresh_access_token_request.dart';

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

  @GET("/user/nonce")
  Future<HttpResponse> getNonce(
    @Header("Authorization") String accessToken,
  );

  @POST("/auth/refresh")
  Future<HttpResponse> refreshAccessToken(
    @Body() RefreshAccessTokenRequest request,
  );
}
