import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Constants/spacing_constants.dart';
import 'package:movie_flutter_demo/Helper/common_button.dart';
import 'package:movie_flutter_demo/Helper/common_radio_button.dart';
import 'package:movie_flutter_demo/Routes/app_router_config.dart';
import 'package:movie_flutter_demo/Screens/signup/bloc/signup_cubit.dart';
import 'package:movie_flutter_demo/Screens/signup/bloc/state/signup_state.dart';
import 'package:movie_flutter_demo/Screens/signup/profile_Image.dart';
import 'package:movie_flutter_demo/Utils/app_localization.dart';
import 'package:movie_flutter_demo/Utils/date_picker.dart';
import 'package:movie_flutter_demo/Helper/common_textfield.dart';
import 'package:movie_flutter_demo/Utils/validator.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final SignupCubit _signupCubit = SignupCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupCubit>(
        create: (context)=> _signupCubit,
        child:Scaffold(
            appBar: AppBar(title: Text(AppLocalization.instance.keys.signUp)),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.only(left: AppPaddings.regular, right: AppPaddings.regular),
                        child:Form(
                            key: _signupCubit.formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize:MainAxisSize.min,
                                children: <Widget>[
                                  BlocBuilder<SignupCubit, SignupState>(
                                    buildWhen: (_,current) {
                                      return current is GenderState;
                                    },
                                      builder: (context, state) {
                                        return ProfileImage(pickerImage: (image) {
                                          _signupCubit.pickedImage = image;
                                        }, gender: _signupCubit.gender);
                                      }),
                                  const SizedBox(height: AppSpacing.regular),
                                  AppRadioButton(label: AppLocalization.instance.keys.gender,
                                      items: [AppLocalization.instance.keys.male, AppLocalization.instance.keys.female, AppLocalization.instance.keys.other],
                                      onChange: (value) {
                                        _signupCubit.updateGender(value);
                                      }),
                                  const SizedBox(height: AppSpacing.regular),
                                  AppTextField(
                                      label: AppLocalization.instance.keys.name,
                                      controller: _signupCubit.nameEditingController,
                                      validator: (value) {
                                        return Validator.isValidName(name: value);
                                      },
                                      inputType: TextInputType.name),
                                  const SizedBox(height: AppSpacing.regular),
                                  AppTextField(
                                      label: AppLocalization.instance.keys.dob,
                                      readOnly: true,
                                      onTap: () {
                                        DatePicker(context,date: (date){
                                          _signupCubit.dobEditingController.text = date;
                                        }).show();
                                      },
                                      controller: _signupCubit.dobEditingController,
                                      validator: (value) {
                                        return Validator.emptyValidate(value: value, message: AppLocalization.instance.keys.dobIsRequired);
                                      },
                                      inputType: TextInputType.emailAddress),
                                  const SizedBox(height: AppSpacing.regular),
                                  AppTextField(
                                      label: AppLocalization.instance.keys.emailAddress,
                                      controller: _signupCubit.emailEditingController,
                                      validator: (value) {
                                        return Validator.isEmailValid(email: value);
                                      },
                                      inputType: TextInputType.emailAddress),
                                  const SizedBox(height: AppSpacing.regular),
                                  AppTextField(
                                      label: AppLocalization.instance.keys.password,
                                      controller: _signupCubit.passwordEditingController,
                                      isPassword: true,
                                      validator: (value) {
                                        return Validator.isValidPassword(password: value);
                                      },
                                      inputType: TextInputType.visiblePassword),
                                  const SizedBox(height: AppSpacing.regular),
                                  AppTextField(
                                      label: AppLocalization.instance.keys.confirmPassword,
                                      controller: _signupCubit.confirmPasswordEditingController,
                                      isPassword: true,
                                      validator: (value) {
                                        return Validator.isValidConfirmPassword(password: value, matchPassword: _signupCubit.passwordEditingController.text);
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
                                          const BottombarRoute().go(context);
                                        }
                                      },
                                      builder: (context, state) {
                                        return AppElevatedButton(title: AppLocalization.instance.keys.signUp, onPressed: () {
                                          SystemChannels.textInput.invokeMethod("TextInput.hide");
                                          _signupCubit.validateForm();
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