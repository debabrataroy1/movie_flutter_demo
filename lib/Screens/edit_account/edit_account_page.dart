import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref_key.dart';
import 'package:movie_flutter_demo/Utils/app_localization.dart';
import 'package:movie_flutter_demo/Utils/app_shared_pref.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Constants/spacing_constants.dart';
import 'package:movie_flutter_demo/Helper/common_button.dart';
import 'package:movie_flutter_demo/Helper/common_radio_button.dart';
import 'package:movie_flutter_demo/Screens/edit_account/cubit/edit_account_cubit.dart';
import 'package:movie_flutter_demo/Screens/edit_account/cubit/state/edit_account_state.dart';
import 'package:movie_flutter_demo/Screens/signup/profile_Image.dart';
import 'package:movie_flutter_demo/Utils/date_picker.dart';
import 'package:movie_flutter_demo/Helper/common_textfield.dart';
import 'package:movie_flutter_demo/Utils/file_manager.dart';
import 'package:movie_flutter_demo/Utils/validator.dart';
import 'dart:io';
import 'package:movie_flutter_demo/di/injector.dart';

class EditAccount extends StatelessWidget {

  final TextEditingController _dobEditingController = TextEditingController();
  final TextEditingController _nameEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final EditAccountCubit _accountCubit = EditAccountCubit();
  final ValueNotifier<String> _gender = ValueNotifier<String>("");
  File? _pickedImage;
  EditAccount({super.key}) {
    SharedPref sharedInstance = AppInjector.getIt<SharedPref>();
    FileManager fileManager = AppInjector.getIt<FileManager>();
    fileManager.getFile(sharedInstance.getString(key: AppSharedPrefKey.profileImage)).then((value){
      _pickedImage = value;
      _gender.value = "";
      _gender.value = sharedInstance.getString(key: AppSharedPrefKey.gender);
    });
    _dobEditingController.text = sharedInstance.getString(key: AppSharedPrefKey.dob);
    _nameEditingController.text = sharedInstance.getString(key: AppSharedPrefKey.fullName);
    _gender.value = sharedInstance.getString(key: AppSharedPrefKey.gender);
  }

  void _validateForm() async {
    if (_formKey.currentState?.validate() == true) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      Map<String, dynamic> params = {
        LoginApiKeys.name: _nameEditingController.text,
        LoginApiKeys.dob: _dobEditingController.text,
        LoginApiKeys.gender: _gender.value
      };
      if (_pickedImage != null) {
        params[LoginApiKeys.image] = _pickedImage;
      }
      _accountCubit.update(params);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditAccountCubit>(
        create: (context)=> _accountCubit,
        child:Scaffold(
            appBar: AppBar(title: Text(AppLocalization.instance.keys.editAccount)),
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
                                  ValueListenableBuilder(
                                      valueListenable: _gender,
                                      builder: (context, value, _) {
                                        return ProfileImage(pickerImage: (image) {
                                          _pickedImage = image;
                                        }, gender: _gender.value, pickedImage: _pickedImage);
                                      }
                                  ),
                                  const SizedBox(height: AppSpacing.regular),
                                  AppRadioButton(label: AppLocalization.instance.keys.gender,
                                      items: [AppLocalization.instance.keys.male, AppLocalization.instance.keys.female, AppLocalization.instance.keys.other],
                                      selectedItem: _gender.value,
                                      onChange: (value) {
                                        _gender.value = value;
                                      }),
                                  const SizedBox(height: AppSpacing.regular),
                                  AppTextField(
                                      label: AppLocalization.instance.keys.name,
                                      controller: _nameEditingController,
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
                                          _dobEditingController.text = date;
                                        }).show();
                                      },
                                      controller: _dobEditingController,
                                      validator: (value) {
                                        return Validator.emptyValidate(value: value, message: AppLocalization.instance.keys.dobIsRequired);
                                      },
                                      inputType: TextInputType.emailAddress),
                                  const SizedBox(height: AppSpacing.regular),
                                  BlocConsumer<EditAccountCubit, EditAccountState>(
                                      listener: (context, state) {
                                        if (state is SuccessState) {
                                          context.pop();
                                        }
                                      },
                                      builder: (context, state) {
                                        return AppElevatedButton(title: AppLocalization.instance.keys.update, onPressed: () {
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
