import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/models.dart';
import '../../dio_provider.dart';
part "avex_api_client.g.dart";

@RestApi(baseUrl: "https://auth.devdeg.com")
abstract class AvexApiClient {
  factory AvexApiClient(Dio dio) = _AvexApiClient;
  @POST("/auth/login")
  Future generateEmailDynamicLink(
    @Body() SignupRequest request
  );
}
// import 'package:dio/dio.dart';
// import 'package:test_project/services/api_services/api_response.dart';
// import 'package:test_project/services/dio_provider.dart';

final avexApiClientProvider =
    Provider<AvexApiClient>((ref) => AvexApiClient(ref.read(dioProvider)));

// class AvexApiClient {
//   late final Dio dio;
//   AvexApiClient(this.dio);
//   // Future<ApiResponse<void>>
//   loginUser() async {
//     final response = await dio.get('https://dart.dev');
//     print(response);
//   }
// }
