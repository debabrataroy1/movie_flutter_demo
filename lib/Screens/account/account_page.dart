import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.account)),
      body: Container(),
    );
  }
}
