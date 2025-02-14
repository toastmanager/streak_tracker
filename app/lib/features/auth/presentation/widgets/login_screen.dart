import 'package:app/core/components/expanded_horizontally.dart';
import 'package:app/features/auth/domain/cubit/auth_cubit.dart';
import 'package:app/generated_code/rest_api.models.swagger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final textTheme = TextTheme.of(context);
    final colors = ColorScheme.of(context);

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isLoading =
            state.maybeWhen(loading: () => true, orElse: () => false);
        final errorMessage =
            state.maybeWhen(error: (message) => message, orElse: () => "");

        return FormBuilder(
          key: formKey,
          enabled: !isLoading,
          child: Padding(
            padding: EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                FormBuilderTextField(
                  name: 'username',
                  decoration: InputDecoration(
                    label: Text('Псевдоним'),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(4),
                  ]),
                ),
                SizedBox(height: 12),
                FormBuilderTextField(
                  name: 'password',
                  decoration: InputDecoration(
                    label: Text('Пароль'),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(4),
                  ]),
                ),
                if (errorMessage != "") ...[
                  SizedBox(height: 12),
                  Text(
                    errorMessage,
                    style: textTheme.bodyMedium?.copyWith(color: colors.error),
                  )
                ],
                SizedBox(height: 12),
                ExpandedHorizontally(
                  child: FilledButton(
                    child: Text('Войти в аккаунт'),
                    onPressed: () {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        final formData = formKey.currentState!.value;
                        context
                            .read<AuthCubit>()
                            .login(form: LoginDto.fromJson(formData));
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
