import 'package:json_annotation/json_annotation.dart';

part 'get_existence_response.g.dart';

@JsonSerializable()
class GetExistenceResponse {
  final bool exists ;
  const GetExistenceResponse({
    required this.exists,
  });
  factory GetExistenceResponse.fromJson(Map<String, dynamic> json) =>
      _$GetExistenceResponseFromJson(json);

}
