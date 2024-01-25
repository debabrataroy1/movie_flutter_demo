import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref_key.dart';
import 'package:movie_flutter_demo/Screens/account/cubit/account_cubit.dart';
import 'package:movie_flutter_demo/Screens/account/cubit/state/account_state.dart';
import 'package:movie_flutter_demo/Utils/app_localization.dart';
import 'package:movie_flutter_demo/Utils/app_shared_pref.dart';
import 'package:movie_flutter_demo/Constants/font_size_constants.dart';
import 'package:movie_flutter_demo/Constants/icons_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Constants/spacing_constants.dart';
import 'package:movie_flutter_demo/Helper/common_alert.dart';
import 'package:movie_flutter_demo/Routes/app_router_config.dart';
import 'package:movie_flutter_demo/Screens/account/widgets/profile_action_widget.dart';
import 'package:movie_flutter_demo/Screens/account/widgets/profile_card_widget.dart';
import 'package:movie_flutter_demo/Screens/account/widgets/profile_image_widget.dart';
import 'package:movie_flutter_demo/Screens/account/widgets/profile_info_widget.dart';
import 'package:movie_flutter_demo/di/injector.dart';

class AccountPage extends StatelessWidget {
  final AccountCubit _accountCubit = AccountCubit();

  AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(AppLocalization.instance.keys.account)),
        body: BlocProvider(
            create: (context) => _accountCubit,
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(left: AppPaddings.regular, right: AppPaddings.regular, top: AppPaddings.regular),
                    child: BlocBuilder<AccountCubit, AccountState>(
                        buildWhen: (_, current) => current is InfoAccountState,
                        builder: (context, state){
                          var info = (state as InfoAccountState).info;
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProfileImageWidget(info.gender ?? '', pickedImage: info.profileImage),
                                const SizedBox(height: AppSpacing.small),
                                Center(child: Text(info.name ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSize.large))),
                                const SizedBox(height: AppSpacing.regular),
                                Text(AppLocalization.instance.keys.personalInformation, style: const TextStyle(fontSize: AppFontSize.regular)),
                                ProfileCardWidget(
                                    child: Column(children: [
                                      Info(AppLocalization.instance.keys.emailAddress, info.email ?? ''),
                                      const Divider(),
                                      Info(AppLocalization.instance.keys.dob, info.dob ?? ''),
                                      const Divider(),
                                      Info(AppLocalization.instance.keys.gender, info.gender ?? ''),
                                    ])
                                ),
                                const SizedBox(height: AppSpacing.small),
                                Text(AppLocalization.instance.keys.utilities, style: const TextStyle(fontSize: AppFontSize.regular)),
                                ProfileCardWidget(
                                    child:Column(
                                        children: [
                                          ProfileActionWidget(AppLocalization.instance.keys.editAccount, AppIcons.account, onTap: () {
                                            const EditAccountRoute().push(context).then((value){
                                              _accountCubit.getAccountData();
                                            });
                                          }),
                                          const Divider(),
                                          ProfileActionWidget(AppLocalization.instance.keys.changePassword, AppIcons.password, onTap: () {
                                            const ChangePasswordRoute().push(context);
                                          }),
                                          const Divider(),
                                          ProfileActionWidget(AppLocalization.instance.keys.logout, AppIcons.logout, onTap: (){
                                            _logout(context);
                                          }),
                                          const Divider(),
                                          ProfileActionWidget(AppLocalization.instance.keys.clearAppData, AppIcons.clear, onTap: (){
                                            _clear(context);
                                          })
                                        ])
                                )
                              ]);
                        })
                )
            )
        )
    );
  }
  void _logout(BuildContext context) {
    AppAlert(title: AppLocalization.instance.keys.logout, message: AppLocalization.instance.keys.logoutMessage, confirmBtnText: AppLocalization.instance.keys.logout,confirmTap: () {
      var appSharedPref = AppInjector.getIt<SharedPref>();
      appSharedPref.remove(AppSharedPrefKey.loginStatus);
      appSharedPref.remove(AppSharedPrefKey.lastActive);
      const OnboardingRoute().go(context);
    }).showDialogBox(context);
  }

  void _clear(BuildContext context) {
    AppAlert(title: AppLocalization.instance.keys.delete, message: AppLocalization.instance.keys.dataDeleteMessage,confirmBtnText:AppLocalization.instance.keys.clear, confirmTap: () {
      var appSharedPref = AppInjector.getIt<SharedPref>();
      appSharedPref.clear();
      const OnboardingRoute().go(context);
    }).showDialogBox(context);
  }
}
