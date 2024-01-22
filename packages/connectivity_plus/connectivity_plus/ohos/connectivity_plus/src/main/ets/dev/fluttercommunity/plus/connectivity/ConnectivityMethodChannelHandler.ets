import MethodCall from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodCall';
import { MethodCallHandler, MethodResult } from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodChannel';
import { Connectivity } from './Connectivity';
import Log from '@ohos/flutter_ohos/src/main/ets/util/Log';


const TAG: string = "ConnectivityMethodChannelHandler";

export default class ConnectivityMethodChannelHandler implements MethodCallHandler {
  private connectivity: Connectivity;

  constructor(connectivity: Connectivity) {
    this.connectivity = connectivity;
  }


  onMethodCall(call: MethodCall, result: MethodResult): void {
    Log.d(TAG, 'onMethodCall step in')
    switch (call.method) {
      case "check":
        result.success(this.connectivity.getNetworkType());
        break;
      default:
        result.notImplemented();
        break;
    }
  }
}



