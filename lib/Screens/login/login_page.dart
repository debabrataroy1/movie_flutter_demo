import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/color_constants.dart';
import 'package:movie_flutter_demo/Constants/font_size_constants.dart';
import 'package:movie_flutter_demo/Constants/icon_size_constants.dart';
import 'package:movie_flutter_demo/Constants/icons_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Constants/spacing_constants.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
import 'package:movie_flutter_demo/Helper/common_button.dart';
import 'package:movie_flutter_demo/Routes/app_router_config.dart';
import 'package:movie_flutter_demo/gen/assets.gen.dart';
import 'package:movie_flutter_demo/Helper/common_textField.dart';
import 'package:movie_flutter_demo/Utils/validator.dart';
import 'bloc/login_cubit.dart';
import 'bloc/state/login_state.dart';

class Login extends StatelessWidget {
  late TextEditingController _emailEditingController, _passwordEditingController;
  late GlobalKey<FormState> _formKey;
  late LoginCubit _loginCubit;

  Login({super.key}) {
    _formKey = GlobalKey();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _loginCubit = LoginCubit();
  }

  void _validateForm() async {
    if (_formKey.currentState?.validate() == true) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      var params = {LoginApiKeys.email: _emailEditingController.text,
        LoginApiKeys.password: _passwordEditingController.text
      };
      _loginCubit.loginIn(params);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
        create: (context)=> _loginCubit,
        child:Scaffold(
            appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                shadowColor: Colors.transparent,
                leading: InkWell(
                    onTap: (){
                      context.pop();
                    },
                    child: const Icon(AppIcons.back,color: AppColors.primaryColor)
                )
            ),
            body: Center(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.only(left: AppPaddings.regular, right: AppPaddings.regular),
                        child:Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize:MainAxisSize.min,
                                children: <Widget>[
                                  Assets.images.logo.image(height: AppIconSize.logo, width: AppIconSize.logo),
                                  const SizedBox(height: AppSpacing.regular),
                                  Text(context.l10n.login,
                                      style: const TextStyle(fontSize: AppFontSize.extraLarge, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: AppSpacing.regular),
                                  Text(context.l10n.signMessage,
                                      style: const TextStyle(fontSize: AppFontSize.regular, fontWeight: FontWeight.w400)),
                                  const SizedBox(height: AppSpacing.large),
                                  AppTextField(
                                    label: context.l10n.emailAddress,
                                    controller: _emailEditingController,
                                    validator: (value) {
                                      if (value != null) {
                                        if (Validator.isEmailValid(context, email: value) != null) {
                                          return Validator.isEmailValid(context, email: value);
                                        }
                                      }
                                      return null;
                                    },
                                    inputType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: AppSpacing.regular),
                                  AppTextField(
                                      label: context.l10n.password,
                                      controller: _passwordEditingController,
                                      isPassword: true,
                                      validator: (value) {
                                        if (value != null) {
                                          if (Validator.isValidPassword(context, password: value) != null) {
                                            return Validator.isValidPassword(context, password: value);
                                          }
                                        }
                                        return null;
                                      },
                                      inputType: TextInputType.visiblePassword
                                  ),
                                  const SizedBox(height: AppSpacing.regular),
                                  BlocConsumer<LoginCubit, LoginState>(
                                      listener: (context, state) {
                                        if (state is LoginError) {
                                          SnackBar snackBar = SnackBar(
                                              content: Text(state.message ?? '')
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        } else if (state is LoginSuccessState) {
                                          const BottombarRoute().go(context);
                                        }
                                      },
                                      builder: (context, state) {
                                        return AppElevatedButton(title: context.l10n.login, onPressed: () {
                                          _validateForm();
                                        });
                                      }),
                                  const SizedBox(height: AppSpacing.regular),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(context.l10n.dontHaveAccount,
                                            style: const TextStyle(fontSize: AppFontSize.regular, fontWeight: FontWeight.w400)),
                                        InkWell(
                                          onTap: (){
                                            const SignupRoute().push(context);
                                          },
                                          child: Text(context.l10n.signUp,
                                              style: const TextStyle(fontSize: AppFontSize.regular,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.primaryColor)),
                                        )
                                      ])
                                ])
                        )
                    )
                )
            )
        )
    );
  }
}
