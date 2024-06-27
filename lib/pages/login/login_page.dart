import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/constant.dart';
import '../../app/routes.dart';
import '../../app/theme.dart';
import '../../utils/permission.dart';
import '../../utils/zegocloud_token.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../zego_call_manager.dart';
import '../../zego_sdk_key_center.dart';
import '../../zego_sdk_manager.dart';
import '../call/call_controller.dart';
import '../provider/login_provider.dart';
import 'provider/userdata_provider.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userIDC = useTextEditingController();
    final usernameC = useTextEditingController();
    List<StreamSubscription> subscriptions = [];
    // ref.listen(loginProvider, (previous, next) {
    //   if (next is LoginSuccess) {
    //     Navigator.pushNamedAndRemoveUntil(
    //         context, listChatRoute, (route) => false);
    //   }
    // });
    useEffect(() {
      subscriptions.addAll([
        ZEGOSDKManager()
            .zimService
            .connectionStateStreamCtrl
            .stream
            .listen((ZIMServiceConnectionStateChangedEvent event) {
          debugPrint('connectionStateStreamCtrl: $event');
          if (event.state == ZIMConnectionState.connected) {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => const HomePage()),
            // );
            Navigator.pushNamedAndRemoveUntil(
                context, mainRoute, (route) => false);
          }
        })
      ]);
      requestPermission();
      return () {};
    }, [
      for (final element in subscriptions) {element.cancel()}
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: [
          Column(
            children: [
              SvgPicture.asset(
                "assets/images/bg_login.svg",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                // height: 300,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: getActualX(context: context, x: defaultMargin)),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          bottom: getActualY(context: context, y: 12)),
                      height: getActualY(context: context, y: 50),
                      width: getActualX(context: context, x: 267),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/logo_splash.png"))),
                    ),
                    Text(
                      "Teman Hidup Sehat Anda",
                      style: textMediumMedium(context: context)
                          .copyWith(color: primaryPresedColor),
                    ),
                    SizedBox(
                      height: getActualY(context: context, y: 40),
                    ),
                    Text(
                      "Log In To Your Doctor Account",
                      style: textLargeMedium(context: context).copyWith(
                          fontSize: getActualY(context: context, y: 20),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: getActualY(context: context, y: 44),
                    ),
                    CustomTextField(
                        labelText: 'User Id',
                        hintText: "Enter Your User ID",
                        controller: userIDC),
                    CustomTextField(
                        marginBottom: 0,
                        labelText: 'Username',
                        hintText: "Enter Your Username",
                        controller: usernameC),
                    SizedBox(
                      height: getActualY(context: context, y: 40),
                    ),
                    CustomButton(
                        text: "Login",
                        onPressed: () async {
                          if (userIDC.text == 'dokter1' ||
                              userIDC.text == 'dokter2') {
                            if (usernameC.text == 'Dokter 1' ||
                                usernameC.text == 'Dokter 2') {
                              ref
                                  .read(currentDataUserIDProvider.notifier)
                                  .state = userIDC.text;
                              // ZIMLoginConfig config = ZIMLoginConfig();
                              // config.userName = userNameController.text;

                              // await ZIM.getInstance()!.login(userIDController.text, config);
                              // init SDK
                              await ZEGOSDKManager().init(SDKKeyCenter.appID,
                                  kIsWeb ? null : SDKKeyCenter.appSign);
                              ZegoCallManager().addListener();
                              ZegoCallController().initService();
                              String? token;
                              if (kIsWeb) {
                                // ! ** Warning: ZegoTokenUtils is only for use during testing. When your application goes live,
                                // ! ** tokens must be generated by the server side. Please do not generate tokens on the client side!
                                token = ZegoTokenUtils.generateToken(
                                    SDKKeyCenter.appID,
                                    SDKKeyCenter.serverSecret,
                                    userIDC.text);
                              }

                              ZEGOSDKManager()
                                  .connectUser(userIDC.text, usernameC.text,
                                      token: token)
                                  .then((_) {
                                ZEGOSDKManager().zimService.updateUserAvatarUrl(
                                    'https://robohash.org/${userIDC.text}.png?set=set4');
                              });

                              ZIMAppConfig appConfig = ZIMAppConfig();
                              appConfig.appID = SDKKeyCenter.appID;
                              appConfig.appSign = SDKKeyCenter.appSign;
                              ZIM.create(appConfig);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("username tidak sesuai")));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("userID tidak sesuai")));
                          }
                        }),
                  ],
                ),
              ),
              // Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have account ? ",
                    style: textSmallReguler(context: context)
                        .copyWith(color: netralColor60),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text("Sign Up",
                        style: textSmallMedium(context: context)
                            .copyWith(color: primaryPresedColor)),
                  )
                ],
              ),
              SizedBox(
                height: getActualY(context: context, y: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
