import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_form_entity.freezed.dart';
part 'login_form_entity.g.dart';

@freezed
class LoginFormEntity with _$LoginFormEntity {
  const factory LoginFormEntity({
    required String username,
    required String password,
  }) = _LoginFormEntity;

  factory LoginFormEntity.fromJson(Map<String, Object?> json) =>
      _$LoginFormEntityFromJson(json);
}
