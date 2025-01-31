import 'dart:io';

import 'package:flutter/material.dart';
import 'package:screen_protector_ohos/screen_protector_ohos.dart';

class ProtectDataLeakagePage extends StatefulWidget {
  const ProtectDataLeakagePage({Key? key}) : super(key: key);

  @override
  _ProtectDataLeakagePageState createState() => _ProtectDataLeakagePageState();
}

class _ProtectDataLeakagePageState extends State<ProtectDataLeakagePage> {
  @override
  void initState() {
    _protectDataLeakageOn();
    super.initState();
  }

  @override
  void dispose() async {
    await ScreenProtector.protectDataLeakageOff();
    super.dispose();
  }

  void _protectDataLeakageOn() async {
    await ScreenProtector.protectDataLeakageOn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Protect Screen Data Leakage'),
      ),
      body: const Center(
        child: Text('Protect Screen Data Leakage'),
      ),
    );
  }
}
