import 'package:app/core/components/avatar.dart';
import 'package:app/core/components/expanded_horizontal.dart';
import 'package:app/features/auth/domain/bloc/auth_bloc.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Avatar(
                size: 74,
                avatarUrl: user.avatarUrl,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: user.username),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                label: Text('Имя пользователя'),
                filled: false,
              ),
            ),
            const SizedBox(height: 8),
            ExpandedHorizontally(
              child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(colors.errorContainer),
                    foregroundColor:
                        WidgetStatePropertyAll(colors.onErrorContainer),
                  ),
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogout());
                  },
                  child: Text('Выйти из аккаунта')),
            )
          ],
        ),
      ),
    );
  }
}
