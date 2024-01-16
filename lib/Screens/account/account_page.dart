import 'dart:io';
import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref.dart';
import 'package:movie_flutter_demo/Constants/font_size_constants.dart';
import 'package:movie_flutter_demo/Constants/icons_constants.dart';
import 'package:movie_flutter_demo/Constants/padding_constants.dart';
import 'package:movie_flutter_demo/Constants/spacing_constants.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
import 'package:movie_flutter_demo/Helper/common_alert.dart';
import 'package:movie_flutter_demo/Routes/app_router_config.dart';
import 'package:movie_flutter_demo/Screens/account/widgets/profile_action_widget.dart';
import 'package:movie_flutter_demo/Screens/account/widgets/profile_card_widget.dart';
import 'package:movie_flutter_demo/Screens/account/widgets/profile_image_widget.dart';
import 'package:movie_flutter_demo/Screens/account/widgets/profile_info_widget.dart';
import 'package:movie_flutter_demo/Utils/file_manager.dart';
import 'package:movie_flutter_demo/di/injector.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  File? _pickedImage;
  String? name, email, dob, gender;
  var sharedInstance = AppInjector.getIt<AppSharedPref>();
  @override
  void initState() {
    getData();
    super.initState();
  }
  getData() async {
    FileManager fileManager = AppInjector.getIt<FileManager>();
    _pickedImage = await fileManager.getFile(await sharedInstance.getString(key: AppSharedPrefKey.profileImage));
    name = await sharedInstance.getString(key: AppSharedPrefKey.fullName);
    email = await sharedInstance.getString(key: AppSharedPrefKey.email);
    dob = await sharedInstance.getString(key: AppSharedPrefKey.dob);
    gender = await sharedInstance.getString(key: AppSharedPrefKey.gender);
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.l10n.account)),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(left: AppPaddings.regular, right: AppPaddings.regular, top: AppPaddings.regular),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileImageWidget(gender ?? '', pickedImage: _pickedImage),
                      const SizedBox(height: AppSpacing.small),
                      Center(child: Text(name ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: AppFontSize.large))),
                      const SizedBox(height: AppSpacing.regular),
                      Text(context.l10n.personalInformation),
                      ProfileCardWidget(
                          child: Column(children: [
                            Info(context.l10n.emailAddress, email ?? ''),
                            const Divider(),
                            Info(context.l10n.dob, dob ?? ''),
                            const Divider(),
                            Info(context.l10n.gender, gender ?? ''),
                          ])
                      ),
                      const SizedBox(height: AppSpacing.small),
                      Text(context.l10n.utilities),
                      ProfileCardWidget(
                          child:Column(
                              children: [
                                ProfileActionWidget(context.l10n.logout, AppIcons.logout, onTap: _logout),
                                const Divider(),
                                ProfileActionWidget(context.l10n.clearAppData, AppIcons.clear, onTap: _clear)
                              ])
                      )
                    ])
            )
        )
    );
  }
  void _logout() {
    AppAlert(title: context.l10n.logout, message: context.l10n.logoutMessage, confirmBtnText: context.l10n.logout,confirmTap: () {
      sharedInstance.remove(AppSharedPrefKey.loginStatus);
      const OnboardingRoute().go(context);
    }).showDialogBox(context);
  }

  void _clear() {
    AppAlert(title: context.l10n.delete, message: context.l10n.dataDeleteMessage,confirmBtnText:context.l10n.clear, confirmTap: () {
      sharedInstance.clear();
      const OnboardingRoute().go(context);
    }).showDialogBox(context);
  }
}
