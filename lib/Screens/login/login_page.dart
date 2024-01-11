import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/color_constants.dart';
import 'package:movie_flutter_demo/Constants/font_size_constants.dart';
import 'package:movie_flutter_demo/Constants/icon_size_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Constants/spacing_constants.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
import 'package:movie_flutter_demo/Helper/CommonButton.dart';
import 'package:movie_flutter_demo/Routes/app_router_config.dart';
import 'package:movie_flutter_demo/gen/assets.gen.dart';
import '../../Helper/CommonTextField.dart';
import '../../Utils/validator.dart';
import 'bloc/login_cubit.dart';
import 'bloc/state/login_state.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailEditingController, _passwordEditingController;
  late GlobalKey<FormState> _formKey;
  late LoginCubit _loginCubit;


  @override
  void initState() {
    _formKey = GlobalKey();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _loginCubit = LoginCubit();
    super.initState();
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

  Widget _emailTextField() {
    return AppTextField(
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
    );
  }

  Widget _passwordTextField() {
    return AppTextField(
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
    );
  }

  Widget _loginButton() {
    return BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            SnackBar snackBar = SnackBar(
              content: Text(state.message ?? '')
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is LoginSuccessState) {
            const BottombarRoute().pushReplacement(context);
          }
        },
        builder: (context, state) {
          return AppElevatedButton(title: context.l10n.login, onPressed: () {
            _validateForm();
          });
        });
  }
  Widget _commonSpacing() {
    return const SizedBox(height: AppSpacing.regular);
  }

  Widget _loginForm() {
    return  Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize:MainAxisSize.min,
        children: <Widget>[
          Assets.images.logo.image(height: AppIconSize.logo, width: AppIconSize.logo),
          _commonSpacing(),
           Text(context.l10n.login,
            style: const TextStyle(fontSize: AppFontSize.extraLarge, fontWeight: FontWeight.w600)),
          _commonSpacing(),
           Text(context.l10n.signMessage,
            style: const TextStyle(fontSize: AppFontSize.regular, fontWeight: FontWeight.w400)),
          const SizedBox(height: AppSpacing.large),
          _emailTextField(),
          _commonSpacing(),
          _passwordTextField(),
          _commonSpacing(),
          _loginButton(),
          _commonSpacing(),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.l10n.dontHaveAccount,
                style: const TextStyle(fontSize: AppFontSize.regular, fontWeight: FontWeight.w400)),
              Text(context.l10n.signUp,
                style: const TextStyle(fontSize: AppFontSize.regular,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor))
            ])
        ])
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context)=> _loginCubit,
      child:Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: AppPaddings.regular, right: AppPaddings.regular),
                child:_loginForm()
              )
            )
          )
      )
    );
  }
}
