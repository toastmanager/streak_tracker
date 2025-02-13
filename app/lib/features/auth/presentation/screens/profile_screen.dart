import 'package:app/generated_code/rest_api.models.swagger.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.userDto,
  });

  final UserDto userDto;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
