import 'package:app/core/routes/router.gr.dart';
import 'package:app/features/auth/domain/cubit/auth_cubit.dart';
import 'package:app/features/auth/presentation/widgets/login_screen.dart';
import 'package:app/features/auth/presentation/widgets/registration_screen.dart';
import 'package:app/features/habits/presentation/components/habit_creation_floating_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.maybeWhen(
          authorized: (user) => AutoTabsRouter(
            routes: [
              const HabitsListRoute(),
              ProfileRoute(user: user),
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
                        label: 'Привычки', icon: Icon(Icons.local_activity)),
                    BottomNavigationBarItem(
                        label: 'Профиль', icon: Icon(Icons.person_rounded)),
                  ],
                ),
              );
            },
          ),
          initial: () => const Scaffold(),
          orElse: () => Scaffold(
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: TabBarView(children: [
                          Center(child: LoginScreen()),
                          Center(child: RegistrationScreen()),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
