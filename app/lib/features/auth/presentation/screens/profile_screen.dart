import 'dart:io';

import 'package:app/core/components/avatar.dart';
import 'package:app/features/auth/domain/cubit/auth_cubit.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/features/auth/presentation/widgets/avatar_viewer.dart';
import 'package:app/generated_code/rest_api.models.swagger.dart';
import 'package:app/injection.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  UserSensitiveDto? user;
  final usernameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final picker = ImagePicker();
  int avatarChanges = 0;
  String errorMessage = '';
  bool isEditing = false;
  XFile? avatarFile;

  void resetChanges() {
    setState(() {
      avatarFile = null;
    });
  }

  void switchIsEditing() {
    resetChanges();
    setState(() => isEditing = !isEditing);
  }

  void cancelChanges() {
    resetChanges();
    setState(() => isEditing = false);
  }

  void confirmChanges() async {
    try {
      final updatedUser = await sl<AuthRepository>().updateMe(
        UpdateMeDto(
          username: usernameTextController.text,
          email: emailTextController.text,
        ),
        avatarFile?.path,
      );
      if (mounted) {
        setState(() {
          errorMessage = '';
          avatarChanges++;
        });
        context.read<AuthCubit>().setUser(updatedUser);
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
    resetChanges();
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
  void initState() {
    final state = context.read<AuthCubit>().state;
    user = state.whenOrNull(
      authorized: (user) => user,
    );
    usernameTextController.text = user?.username ?? '';
    emailTextController.text = user?.email ?? '';
    super.initState();
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
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            user = state.whenOrNull(
              authorized: (user) => user,
            );
          },
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return Column(
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
                                if (formKey.currentState?.saveAndValidate() ??
                                    true) {
                                  confirmChanges();
                                }
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
                        cursor: isEditing
                            ? SystemMouseCursors.click
                            : MouseCursor.defer,
                        child: GestureDetector(
                          onTap: () async {
                            if (isEditing) {
                              final pickedAvatarFile = await picker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() => avatarFile = pickedAvatarFile);
                            } else {
                              if (user?.avatarUrl != null &&
                                  user?.avatarUrl != '') {
                                showDialog(
                                    context: context,
                                    builder: (context) => AvatarViewer(
                                          imageUrl: user!.avatarUrl!,
                                        ));
                              }
                            }
                          },
                          child: Column(
                            children: [
                              isEditing && avatarFile != null
                                  ? ClipOval(
                                      child: Image.file(
                                        width: 80,
                                        height: 80,
                                        File(avatarFile!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Avatar(
                                      avatarUrl: user?.avatarUrl,
                                      cacheKey: user?.avatarUrl != null &&
                                              user?.avatarUrl != ''
                                          ? user!.avatarUrl! +
                                              avatarChanges.toString()
                                          : null,
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
                    key: formKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'username',
                          readOnly: !isEditing,
                          controller: usernameTextController,
                          decoration: InputDecoration(
                            label: Text('Псевдоним'),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(4),
                          ]),
                        ),
                        const SizedBox(height: 12),
                        FormBuilderTextField(
                          name: 'email',
                          readOnly: !isEditing,
                          controller: emailTextController,
                          decoration: InputDecoration(
                            label: Text('Почта'),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                        ),
                        if (errorMessage != '') SizedBox(height: 8),
                        if (errorMessage != '')
                          Text(
                            errorMessage,
                            style: textTheme.bodySmall
                                ?.copyWith(color: colors.error),
                          ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
