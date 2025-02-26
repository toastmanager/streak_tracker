// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/features/auth/presentation/screens/profile_screen.dart'
    as _i4;
import 'package:app/features/habits/presentation/screens/habit_details_screen.dart'
    as _i1;
import 'package:app/features/habits/presentation/screens/habit_list_screen.dart'
    as _i2;
import 'package:app/main_screen.dart' as _i3;
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

/// generated route for
/// [_i1.ActivityDetailsScreen]
class ActivityDetailsRoute extends _i5.PageRouteInfo<ActivityDetailsRouteArgs> {
  ActivityDetailsRoute({
    _i6.Key? key,
    required int id,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          ActivityDetailsRoute.name,
          args: ActivityDetailsRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'ActivityDetailsRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ActivityDetailsRouteArgs>();
      return _i1.ActivityDetailsScreen(
        key: args.key,
        id: args.id,
      );
    },
  );
}

class ActivityDetailsRouteArgs {
  const ActivityDetailsRouteArgs({
    this.key,
    required this.id,
  });

  final _i6.Key? key;

  final int id;

  @override
  String toString() {
    return 'ActivityDetailsRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i2.HabitsListScreen]
class HabitsListRoute extends _i5.PageRouteInfo<void> {
  const HabitsListRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HabitsListRoute.name,
          initialChildren: children,
        );

  static const String name = 'HabitsListRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.HabitsListScreen();
    },
  );
}

/// generated route for
/// [_i3.MainScreen]
class MainRoute extends _i5.PageRouteInfo<void> {
  const MainRoute({List<_i5.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.MainScreen();
    },
  );
}

/// generated route for
/// [_i4.ProfileScreen]
class ProfileRoute extends _i5.PageRouteInfo<void> {
  const ProfileRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.ProfileScreen();
    },
  );
}
