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
import 'package:movie_flutter_demo/Helper/common_button.dart';
import 'package:movie_flutter_demo/Routes/app_router_config.dart';
import 'package:movie_flutter_demo/Utils/app_localization.dart';
import 'package:movie_flutter_demo/gen/assets.gen.dart';
import 'package:movie_flutter_demo/Helper/common_textfield.dart';
import 'package:movie_flutter_demo/Utils/validator.dart';
import 'bloc/login_cubit.dart';
import 'bloc/state/login_state.dart';

class Login extends StatelessWidget {

  late LoginCubit _loginCubit;

  Login({super.key}) {
    _loginCubit = LoginCubit();
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
                            key: _loginCubit.formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize:MainAxisSize.min,
                                children: <Widget>[
                                  Assets.images.logo.image(height: AppIconSize.logo, width: AppIconSize.logo),
                                  const SizedBox(height: AppSpacing.regular),
                                  Text(AppLocalization.instance.keys.login,
                                      style: const TextStyle(fontSize: AppFontSize.extraLarge, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: AppSpacing.regular),
                                  Text(AppLocalization.instance.keys.signMessage,
                                      style: const TextStyle(fontSize: AppFontSize.regular, fontWeight: FontWeight.w400)),
                                  const SizedBox(height: AppSpacing.large),
                                  AppTextField(
                                    label: AppLocalization.instance.keys.emailAddress,
                                    controller: _loginCubit.emailEditingController,
                                    validator: (value) {
                                      return Validator.isEmailValid(email: value);
                                    },
                                    inputType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: AppSpacing.regular),
                                  AppTextField(
                                      label: AppLocalization.instance.keys.password,
                                      controller: _loginCubit.passwordEditingController,
                                      isPassword: true,
                                      validator: (value) {
                                        return Validator.isValidPassword(password: value);
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
                                        return AppElevatedButton(title: AppLocalization.instance.keys.login, onPressed: () {
                                          SystemChannels.textInput.invokeMethod("TextInput.hide");
                                          _loginCubit.validateForm();
                                        });
                                      }),
                                  const SizedBox(height: AppSpacing.regular),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(AppLocalization.instance.keys.dontHaveAccount,
                                            style: const TextStyle(fontSize: AppFontSize.regular, fontWeight: FontWeight.w400)),
                                        InkWell(
                                            onTap: (){
                                              const SignupRoute().push(context);
                                            },
                                            child: Text(AppLocalization.instance.keys.signUp,
                                                style: const TextStyle(fontSize: AppFontSize.regular,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.primaryColor))
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
