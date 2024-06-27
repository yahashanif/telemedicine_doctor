import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zego_zim/zego_zim.dart';

import '../../app/config.dart';
import '../../app/constant.dart';
import '../../app/routes.dart';
import '../../app/theme.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(const Duration(seconds: 3), () {
      ZIMAppConfig appConfig = ZIMAppConfig();
      appConfig.appID = Config.instance.appIDChat;
      appConfig.appSign = Config.instance.appSignChat;
      print(appConfig.appID);
      print(appConfig.appSign);
      ZIM zim = ZIM.create(appConfig)!;
      Navigator.pushNamedAndRemoveUntil(context, loginRoute, (route) => false);
    });

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: getActualX(x: defaultMargin, context: context)),
        color: netralColor10,
        child: Center(
          child: Image.asset(
            "assets/images/logo_splash.png",
            width: 200,
            scale: 1,
          ),
        ),
      ),
    );
  }
}
