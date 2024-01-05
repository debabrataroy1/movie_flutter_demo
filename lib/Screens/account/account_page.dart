import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/app_string_constant.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.account)),
      body: Container(),
    );
  }
}
