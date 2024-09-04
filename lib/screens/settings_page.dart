import 'package:dummy_api_call_retrofit/screens/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../generated/l10n.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<Language> lanList = [
    Language("English", true),
    Language("Arabic", false),
    Language("Japanese", false),
  ];
  ValueNotifier<bool> shippingSwitch = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        showTitle: true,
        title: S.of(context).settings,
        leadingIcon: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25).r,
          child: const Column(
            children: [],
          ),
        ),
      ),
    );
  }
}

class Language {
  String lan;
  bool isSelected;

  Language(this.lan, this.isSelected);
}
