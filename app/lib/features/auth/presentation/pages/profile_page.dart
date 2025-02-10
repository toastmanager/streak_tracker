import 'package:app/features/auth/domain/bloc/auth_bloc.dart';
import 'package:app/features/auth/domain/cubit/login_cubit.dart';
import 'package:app/features/auth/domain/cubit/registration_cubit.dart';
import 'package:app/features/auth/presentation/screens/login_screen.dart';
import 'package:app/features/auth/presentation/screens/profile_screen.dart';
import 'package:app/features/auth/presentation/screens/registration_screen.dart';
import 'package:app/injection.dart';
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
        return state.whenOrNull(
              initial: () => const SizedBox(),
              error: (message) => Text(message),
              logged: (user) => ProfileScreen(user: user),
            ) ??
            MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => sl<LoginCubit>()),
                BlocProvider(create: (context) => sl<RegistrationCubit>()),
              ],
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(text: 'Вход'),
                        Tab(text: 'Регистрация'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        LoginScreen(),
                        RegistrationScreen(),
                      ]),
                    ),
                  ],
                ),
              ),
            );
      },
    );
  }
}
