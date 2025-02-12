import 'package:app/core/routes/router.gr.dart';
import 'package:app/features/activities/presentation/components/habit_creation_floating_button.dart';
import 'package:app/features/auth/domain/bloc/auth_bloc.dart';
import 'package:app/features/auth/domain/cubit/login_cubit.dart';
import 'package:app/features/auth/domain/cubit/registration_cubit.dart';
import 'package:app/features/auth/presentation/screens/login_screen.dart';
import 'package:app/features/auth/presentation/screens/registration_screen.dart';
import 'package:app/injection.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return state.maybeWhen(
          logged: (user) => AutoTabsRouter(
            routes: const [
              ActivityListRoute(),
              ProfileRoute(),
            ],
            builder: (context, child) {
              final tabsRouter = AutoTabsRouter.of(context);
              return Scaffold(
                body: SafeArea(child: child),
                floatingActionButton: tabsRouter.activeIndex == 0
                    ? HabitCreationFloatingButton()
                    : null,
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: tabsRouter.activeIndex,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  onTap: (index) {
                    tabsRouter.setActiveIndex(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                        label: 'Activities', icon: Icon(Icons.local_activity)),
                    BottomNavigationBarItem(
                        label: 'Profile', icon: Icon(Icons.person_rounded)),
                  ],
                ),
              );
            },
          ),
          loading: () => const Scaffold(),
          initial: () => const Scaffold(),
          orElse: () => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<LoginCubit>()),
              BlocProvider(create: (context) => sl<RegistrationCubit>()),
            ],
            child: Scaffold(
              body: SafeArea(
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
              ),
            ),
          ),
        );
      },
    );
  }
}
