import {
  FlutterPlugin,
  FlutterPluginBinding
} from '@ohos/flutter_ohos/src/main/ets/embedding/engine/plugins/FlutterPlugin';
import MethodChannel from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodChannel';
import EventChannel from '@ohos/flutter_ohos/src/main/ets/plugin/common/EventChannel';
import { ConnectivityBroadcastReceiver } from './ConnectivityBroadcastReceiver';
import { Connectivity } from './Connectivity';
import ConnectivityMethodChannelHandler from './ConnectivityMethodChannelHandler';
import Log from '@ohos/flutter_ohos/src/main/ets/util/Log';
import StandardMethodCodec from '@ohos/flutter_ohos/src/main/ets/plugin/common/StandardMethodCodec';

const TAG: string = "ConnectivityPlugin";

export default class ConnectivityPlugin implements FlutterPlugin {
  private methodChannel: MethodChannel | null = null;
  private eventChannel: EventChannel | null = null;
  private receiver: ConnectivityBroadcastReceiver | null = null;
  private pluginBing: FlutterPluginBinding | null = null;

  getUniqueClassName(): string {
    return "ConnectivityPlugin";
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    Log.d(TAG, 'onAttachedToEngine connectivity plugin')

    let taskQueue = binding.getBinaryMessenger().makeBackgroundTaskQueue();

    this.methodChannel = new MethodChannel(binding.getBinaryMessenger(), "dev.fluttercommunity.plus/connectivity", StandardMethodCodec.INSTANCE, taskQueue);
    this.eventChannel = new EventChannel(binding.getBinaryMessenger(), "dev.fluttercommunity.plus/connectivity_status", StandardMethodCodec.INSTANCE, taskQueue);

    let connectivity = new Connectivity();
    let methodChannelHandler = new ConnectivityMethodChannelHandler(connectivity);
    this.receiver = new ConnectivityBroadcastReceiver(binding.getApplicationContext(), connectivity);
    this.methodChannel.setMethodCallHandler(methodChannelHandler);
    this.eventChannel.setStreamHandler(this.receiver);
    this.pluginBing = binding;
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    Log.d(TAG, 'onDetachedFromEngine connectivity plugin')
    this.methodChannel?.setMethodCallHandler(null);
    this.eventChannel?.setStreamHandler(null);
    this.receiver?.onCancel();
    this.methodChannel = null;
    this.eventChannel = null;
    this.receiver = null;
    this.pluginBing = null;
  }
}
