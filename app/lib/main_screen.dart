import 'package:app/core/routes/router.gr.dart';
import 'package:app/features/activities/presentation/components/habit_creation_floating_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
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
    );
  }
}
