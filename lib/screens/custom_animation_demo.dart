import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class CustomAnimationDemo extends StatefulWidget {
  const CustomAnimationDemo({super.key});

  @override
  State<CustomAnimationDemo> createState() => _CustomAnimationDemoState();
}

class _CustomAnimationDemoState extends State<CustomAnimationDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).customAnimationDemo),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
