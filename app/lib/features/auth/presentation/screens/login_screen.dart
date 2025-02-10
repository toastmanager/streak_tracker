import 'package:app/core/components/expanded_horizontal.dart';
import 'package:app/features/auth/domain/bloc/auth_bloc.dart';
import 'package:app/features/auth/domain/cubit/login_cubit.dart';
import 'package:app/features/auth/domain/entities/login_form_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final submitButtonFocusNode = FocusNode();
  bool isPasswordObscure = true;

  @override
  void dispose() {
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    submitButtonFocusNode.dispose();
    super.dispose();
  }

  void switchIsPasswordObscure() {
    setState(() {
      isPasswordObscure = !isPasswordObscure;
    });
  }

  void _login() {
    final loginForm = LoginFormEntity.fromJson(_formKey.currentState!.value);
    context.read<AuthBloc>().add(AuthLogin(loginForm));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colors = ColorScheme.of(context);

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final isLoading = state.whenOrNull(loading: () => true) == true;
              return FormBuilder(
                key: _formKey,
                enabled: !isLoading,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Вход',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      focusNode: usernameFocusNode,
                      name: 'username',
                      decoration: InputDecoration(
                        hintText: 'Имя пользователя',
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      onSubmitted: (value) => FocusScope.of(context)
                          .requestFocus(passwordFocusNode),
                    ),
                    const SizedBox(height: 8),
                    FormBuilderTextField(
                      focusNode: passwordFocusNode,
                      name: 'password',
                      obscureText: isPasswordObscure,
                      onSubmitted: (value) => FocusScope.of(context)
                          .requestFocus(submitButtonFocusNode),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      decoration: InputDecoration(
                        hintText: 'Пароль',
                        suffixIcon: IconButton(
                          onPressed: switchIsPasswordObscure,
                          icon: Icon(isPasswordObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                    BlocSelector<LoginCubit, LoginState, String?>(
                      selector: (state) => state.whenOrNull(
                          initial: (errorMessage) => errorMessage),
                      builder: (context, errorMessage) {
                        return errorMessage == null
                            ? const SizedBox()
                            : Column(
                                children: [
                                  const SizedBox(height: 16),
                                  Text(
                                    errorMessage,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: colors.error,
                                    ),
                                  )
                                ],
                              );
                      },
                    ),
                    const SizedBox(height: 16),
                    ExpandedHorizontally(
                        child: FilledButton(
                            focusNode: submitButtonFocusNode,
                            onPressed: isLoading
                                ? null
                                : () {
                                    if (_formKey.currentState
                                            ?.saveAndValidate() ==
                                        true) {
                                      _login();
                                    }
                                  },
                            child: Text('Войти'))),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
