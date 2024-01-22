import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Constants/spacing_constants.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
import 'package:movie_flutter_demo/Helper/common_button.dart';
import 'package:movie_flutter_demo/Screens/change_password/cubit/change_password_cubit.dart';
import 'package:movie_flutter_demo/Screens/change_password/cubit/state/change_password_state.dart';
import 'package:movie_flutter_demo/Helper/common_textfield.dart';
import 'package:movie_flutter_demo/Utils/validator.dart';


class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  final TextEditingController _confirmPasswordEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final TextEditingController _oldPasswordEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final ChangePasswordCubit _changePasswordCubit = ChangePasswordCubit();

  void _validateForm(BuildContext context) async {
    if (_formKey.currentState?.validate() == true) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      Map<String, dynamic> params = {
        LoginApiKeys.password: _passwordEditingController.text,
        LoginApiKeys.oldPassword: _oldPasswordEditingController.text,
      };
      _changePasswordCubit.update(context, params);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordCubit>(
        create: (context)=> _changePasswordCubit,
        child:Scaffold(
            appBar: AppBar(title: Text(context.l10n.confirmPassword)),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.only(left: AppPaddings.regular, right: AppPaddings.regular),
                        child:Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize:MainAxisSize.min,
                                children: <Widget>[
                                  const SizedBox(height: AppSpacing.regular),
                                  AppTextField(
                                      label: context.l10n.oldPassword,
                                      controller: _oldPasswordEditingController,
                                      isPassword: true,
                                      validator: (value) {
                                        return Validator.isValidPassword(context, password: value);
                                      },
                                      inputType: TextInputType.visiblePassword),
                                  const SizedBox(height: AppSpacing.regular),
                                  AppTextField(
                                      label: context.l10n.newPassword,
                                      controller: _passwordEditingController,
                                      isPassword: true,
                                      validator: (value) {
                                        return Validator.isValidPassword(context, password: value);
                                      },
                                      inputType: TextInputType.visiblePassword),
                                  const SizedBox(height: AppSpacing.regular),
                                  AppTextField(
                                      label: context.l10n.confirmPassword,
                                      controller: _confirmPasswordEditingController,
                                      isPassword: true,
                                      validator: (value) {
                                        return Validator.isValidConfirmPassword(context, password: value, matchPassword: _passwordEditingController.text);
                                      },
                                      inputType: TextInputType.visiblePassword),
                                  const SizedBox(height: AppSpacing.regular),
                                  BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                                      listener: (context, state) {
                                        if (state is ErrorState) {
                                          SnackBar snackBar = SnackBar(
                                              content: Text(state.message ?? '')
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        } else if (state is SuccessState) {
                                          context.pop();
                                        }
                                      },
                                      builder: (context, state) {
                                        return AppElevatedButton(title: context.l10n.update, onPressed: () {
                                          _validateForm(context);
                                        });
                                      })
                                ])
                        )
                    )
                )
            )
        )
    );
  }
}
