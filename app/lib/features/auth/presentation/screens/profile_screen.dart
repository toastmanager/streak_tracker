import 'package:app/core/components/avatar.dart';
import 'package:app/features/auth/domain/cubit/auth_cubit.dart';
import 'package:app/generated_code/rest_api.models.swagger.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.user,
  });

  final UserDto user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final user = widget.user;
  late final usernameTextController =
      TextEditingController(text: user.username);
  late final emailTextController =
      TextEditingController(text: 'example@example.com');
  bool isEditing = false;

  void switchIsEditing() {
    setState(() => isEditing = !isEditing);
  }

  void cancelChanges() {
    setState(() => isEditing = false);
  }

  void confirmChanges() {
    setState(() => isEditing = false);
  }

  void showLogoutAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Вы уверены что хотите выйти из аккаунта?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              await context.read<AuthCubit>().logout();
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
            child: Text(
              'Выйти',
              style: TextTheme.of(context).bodyMedium?.copyWith(
                    color: ColorScheme.of(context).error,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    usernameTextController.dispose();
    emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (isEditing) {
                          cancelChanges();
                        } else {
                          showLogoutAlert(context);
                        }
                      },
                      child: Text(
                        isEditing ? 'Отмена' : 'Выйти',
                        style: textTheme.bodySmall
                            ?.copyWith(color: colors.onSurfaceVariant),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (isEditing) {
                          confirmChanges();
                        } else {
                          switchIsEditing();
                        }
                      },
                      child: Text(
                        isEditing ? 'Готово' : 'Редактировать',
                        style: textTheme.bodySmall?.copyWith(
                          color: colors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                MouseRegion(
                  cursor:
                      isEditing ? SystemMouseCursors.click : MouseCursor.defer,
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Avatar(
                          avatarUrl: user.avatarUrl,
                          size: 80,
                        ),
                        if (isEditing) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Изменить аватарку',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: colors.primary),
                          )
                        ],
                        if (!isEditing) const SizedBox(height: 28),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FormBuilder(
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'username',
                    readOnly: !isEditing,
                    controller: usernameTextController,
                    decoration: InputDecoration(
                      label: Text('Псевдоним'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  FormBuilderTextField(
                    name: 'email',
                    readOnly: !isEditing,
                    controller: emailTextController,
                    decoration: InputDecoration(
                      label: Text('Почта'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
