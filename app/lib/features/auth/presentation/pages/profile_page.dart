import 'package:app/features/auth/domain/bloc/auth_bloc.dart';
import 'package:app/features/auth/presentation/screens/profile_screen.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return state.maybeWhen(
          error: (message) => Text(message),
          logged: (user) => ProfileScreen(user: user),
          orElse: () => const SizedBox(),
        );
      },
    );
  }
}
