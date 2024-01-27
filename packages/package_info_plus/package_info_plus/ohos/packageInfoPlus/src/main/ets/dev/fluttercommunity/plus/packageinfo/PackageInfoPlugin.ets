import AbilityAware from '@ohos/flutter_ohos/src/main/ets/embedding/engine/plugins/ability/AbilityAware';
import { AbilityPluginBinding } from '@ohos/flutter_ohos/src/main/ets/embedding/engine/plugins/ability/AbilityPluginBinding';
import { FlutterPlugin, FlutterPluginBinding } from '@ohos/flutter_ohos/src/main/ets/embedding/engine/plugins/FlutterPlugin';
import { MethodCallHandler, MethodResult } from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodChannel';
import MethodChannel from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodChannel';
import MethodCall from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodCall';
import Log from '@ohos/flutter_ohos/src/main/ets/util/Log';
import HashMap from '@ohos.util.HashMap';


import bundleManager from '@ohos.bundle.bundleManager'
let bundleFlags =  bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION | bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_SIGNATURE_INFO

const TAG:string ="PackageInfoPlugin"

const CHANNEL_NAME = "dev.fluttercommunity.plus/package_info";
export class PackageInfoPlugin implements FlutterPlugin,MethodCallHandler{


  getUniqueClassName(): string {
    return "PackageInfoPlugin";
  }


  private methodChannel: MethodChannel | null = null;

  private applicationContext: Context | null = null;

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    Log.d(TAG,'onAttachedToEngine packageInfo plugin')
    this.applicationContext =binding.getApplicationContext();
    this.methodChannel = new MethodChannel(binding.getBinaryMessenger(), CHANNEL_NAME);
    this.methodChannel.setMethodCallHandler(this);

  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    Log.d(TAG,'onDetachedFromEngine packageInfo plugin')
    this.applicationContext = null;
    this.methodChannel?.setMethodCallHandler(null);
    this.methodChannel = null;
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    Log.d(TAG,'onMethodCall packageInfo plugin1')
    try {
             if (call.method == "getAll") {

               const bundleManage = bundleManager.getBundleInfoForSelfSync(bundleFlags);
               const appInfo = bundleManage.appInfo;

               const infoMap = new Map<string,string>();
               const buildSignature = bundleManage.signatureInfo.fingerprint;
               infoMap.set("appName",appInfo.name);
               Log.d(TAG,'onMethodCall packageInfo plugin appName '+appInfo.name)
               infoMap.set("packageName",bundleManage.name);
               Log.d(TAG,'onMethodCall packageInfo plugin packageName '+bundleManage.name)
               infoMap.set("version",bundleManage.versionName);
               Log.d(TAG,'onMethodCall packageInfo plugin version '+bundleManage.versionName)
               infoMap.set("buildNumber",bundleManage.versionCode.toString());
               Log.d(TAG,'onMethodCall packageInfo plugin buildNumber '+bundleManage.versionCode.toString())
               if (buildSignature != null){
                 infoMap.set("buildSignature",buildSignature);
                 Log.d(TAG,'onMethodCall packageInfo plugin buildSignature '+buildSignature)
               }
              infoMap.set("installerStore","");

               result.success(infoMap);
            } else {
               result.notImplemented()
             }
    } catch(err){
      result.error("Name not found", err.message, null)
    }
  }

}
