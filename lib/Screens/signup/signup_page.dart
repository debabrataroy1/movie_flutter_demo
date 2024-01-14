import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Constants/spacing_constants.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
import 'package:movie_flutter_demo/Helper/CommonButton.dart';
import 'package:movie_flutter_demo/Helper/common_radio_button.dart';
import 'package:movie_flutter_demo/Routes/app_router_config.dart';
import 'package:movie_flutter_demo/Screens/signup/bloc/signup_cubit.dart';
import 'package:movie_flutter_demo/Screens/signup/bloc/state/signup_state.dart';
import 'package:movie_flutter_demo/Screens/signup/profile_Image.dart';
import 'package:movie_flutter_demo/Utils/date_picker.dart';
import 'package:movie_flutter_demo/Helper/CommonTextField.dart';
import 'package:movie_flutter_demo/Utils/validator.dart';
import 'dart:io';

class SignupPage extends StatelessWidget {

  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final TextEditingController _dobEditingController = TextEditingController();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _confirmPasswordEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final SignupCubit _signupCubit = SignupCubit();
  String genter = "";
  File? _pickedImage;

  void _validateForm() async {
    if (_formKey.currentState?.validate() == true) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      Map<String, dynamic> params = {LoginApiKeys.email: _emailEditingController.text,
        LoginApiKeys.password: _passwordEditingController.text,
        LoginApiKeys.name: _nameEditingController.text,
        LoginApiKeys.dob: _dobEditingController.text,
        LoginApiKeys.gender: genter
      };
      if (_pickedImage != null) {
        params[LoginApiKeys.image] = _pickedImage;
      }
      _signupCubit.signup(params);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupCubit>(
        create: (context)=> _signupCubit,
        child:Scaffold(
            appBar: AppBar(title: Text(context.l10n.signUp)),
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
                                   ProfileImage(pickerImage: (image){
                                    _pickedImage = image;
                                  }),
                                  const SizedBox(height: AppSpacing.regular),
                                  AppRadioButton(label: context.l10n.gender,
                                      items: [context.l10n.male, context.l10n.female, context.l10n.other],
                                  onChange: (value) {
                                    genter = value;
                                    }),
                                  const SizedBox(height: AppSpacing.regular),
                                  AppTextField(
                                      label: context.l10n.name,
                                      controller: _nameEditingController,
                                      validator: (value) {
                                        if (value != null) {
                                          if (Validator.isValidName(context, name: value) != null) {
                                            return Validator.isValidName(context, name: value);
                                          }
                                        }
                                        return null;
                                      },
                                      inputType: TextInputType.name),
                                  const SizedBox(height: AppSpacing.regular),
                                  AppTextField(
                                      label: context.l10n.dob,
                                      readOnly: true,
                                      onTap: () {
                                        DatePicker(context,date: (date){
                                          _dobEditingController.text = date;
                                        }).show();
                                      },
                                      controller: _dobEditingController,
                                      validator: (value) {
                                        if (value != null) {
                                          if (Validator.isEmpty(value)) {
                                            return context.l10n.dobIsRequired;
                                          }
                                        }
                                        return null;
                                      },
                                      inputType: TextInputType.emailAddress),
                                  const SizedBox(height: AppSpacing.regular),
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
                                      inputType: TextInputType.emailAddress),
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
                                      inputType: TextInputType.visiblePassword),
                                  const SizedBox(height: AppSpacing.regular),
                                  AppTextField(
                                      label: context.l10n.confirmPassword,
                                      controller: _confirmPasswordEditingController,
                                      isPassword: true,
                                      validator: (value) {
                                        if (value != null) {
                                          if (Validator.isValidPassword(context, password: value) != null) {
                                            return Validator.isValidPassword(context, password: value);
                                          } else if (_passwordEditingController.text != value) {
                                            return context.l10n.passwordMismatch;
                                          }
                                        }
                                        return null;
                                      },
                                      inputType: TextInputType.visiblePassword),
                                  const SizedBox(height: AppSpacing.regular),
                                  BlocConsumer<SignupCubit, SignupState>(
                                      listener: (context, state) {
                                        if (state is SignupError) {
                                          SnackBar snackBar = SnackBar(
                                              content: Text(state.message ?? '')
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        } else if (state is SignupSuccessState) {
                                          const BottombarRoute().pushReplacement(context);
                                        }
                                      },
                                      builder: (context, state) {
                                        return AppElevatedButton(title: context.l10n.signUp, onPressed: () {
                                          _validateForm();
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
