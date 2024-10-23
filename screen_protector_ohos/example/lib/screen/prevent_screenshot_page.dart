import 'package:flutter/material.dart';
import 'package:screen_protector_ohos/screen_protector_ohos.dart';

class PreventScreenshotPage extends StatefulWidget {
  const PreventScreenshotPage({Key? key}) : super(key: key);

  @override
  _PreventScreenshotPageState createState() => _PreventScreenshotPageState();
}

class _PreventScreenshotPageState extends State<PreventScreenshotPage> {
  @override
  void initState() {
    _preventScreenshotOn();
    super.initState();
  }

  @override
  void dispose() {
    _preventScreenshotOff();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Prevent Screenshot'),
      ),
      body: const Center(
        child: Text('Secure Screen'),
      ),
    );
  }


  void _preventScreenshotOn() async =>
      await ScreenProtector.preventScreenshotOn();

  void _preventScreenshotOff() async =>
      await ScreenProtector.preventScreenshotOff();

}
