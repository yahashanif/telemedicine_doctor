import 'package:zego_express_engine/zego_express_engine.dart' show ZegoScenario;

class Config {
  static final Config instance = Config._internal();
  Config._internal();

  int appIDChat = 1160594769;

  // It is for native only, do not use it for web!
  String appSignChat =
      "13889807ee38c797bf50b7f4b434dca3f717fd38fdb34d484beaa5a3b7f3248d";
  int appIDVideoCall = 1547103424;

  // It is for native only, do not use it for web!
  String appSignVideoCall =
      "48bddfd84cb2dd08ac009966c80adbd6d20772f07dd2205a49af998df88c00b0";

  String appServerKeyVideoCall = "0e9927989cc96d44366bc3e1780539fb";

  // It is required for web and is recommended for native but not required.
  String token = "";

  ZegoScenario scenario = ZegoScenario.Default;
  bool enablePlatformView = false;

  String userID = "";
  String userName = "";

  bool isPreviewMirror = true;
  bool isPublishMirror = false;

  bool enableHardwareEncoder = false;
}
