import 'package:freezed_annotation/freezed_annotation.dart';
part 'register_form_entity.freezed.dart';
part 'register_form_entity.g.dart';

@freezed
class RegisterFormEntity with _$RegisterFormEntity {
  const factory RegisterFormEntity({
    required String username,
    required String email,
    required String password,
  }) = _RegisterFormEntity;

  factory RegisterFormEntity.fromJson(Map<String, Object?> json) =>
      _$RegisterFormEntityFromJson(json);
}
