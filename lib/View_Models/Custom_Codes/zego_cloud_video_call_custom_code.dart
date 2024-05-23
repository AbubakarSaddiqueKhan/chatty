import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

const appID = 1517302870;
const appSign =
    "4fe6324b9054158dea7d4df97b56867a9857269e25384c8f62943311ba9cc092";
const serverSecret = "6bce6bc691107d8724e56ebc00166f81";

Future<void> createEngine() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Get your AppID and AppSign from ZEGOCLOUD Console
  //[My Projects -> AppID] : https://console.zegocloud.com/project
  await ZegoExpressEngine.createEngineWithProfile(ZegoEngineProfile(
    appID,
    ZegoScenario.Default,
    appSign: kIsWeb ? null : appSign,
  ));
}
