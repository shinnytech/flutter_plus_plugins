import { StreamHandler, EventSink } from '@ohos/flutter_ohos/src/main/ets/plugin/common/EventChannel';
import { Connectivity } from './Connectivity';

//创建tag
const TAG = "ConnectivityBroadcastReceiver";

//创建类
export class ConnectivityBroadcastReceiver implements StreamHandler {
  private connectivity: Connectivity;
  private context: Context;
  private events: EventSink | null = null;

  constructor(context: Context, connectivity: Connectivity) {
    this.context = context;
    this.connectivity = connectivity;
  }

  onListen(args: Object, events: EventSink): void {
    this.events = events;

    Connectivity.netConnection.register((error) => {
      this.sendEvent(this.connectivity.getNetworkType())
    })

    //订阅网络可用事件。
    Connectivity.netConnection.on('netAvailable', (data) => {
      this.sendEvent(this.connectivity.getNetworkType())
    })

    //订阅网络能力变化事件。
    Connectivity.netConnection.on('netCapabilitiesChange', (data) => {
      this.sendEvent(this.connectivity.getNetworkType())
    })

    //订阅网络连接信息变化事件
    Connectivity.netConnection.on('netConnectionPropertiesChange', (data) => {
      this.sendEvent(this.connectivity.getNetworkType())
    })

    //订阅网络订阅网络丢失事件。
    Connectivity.netConnection.on('netLost', (data) => {
      this.sendEvent(Connectivity.CONNECTIVITY_NONE)
    })

    //订阅网络不可用事件。
    Connectivity.netConnection.on('netUnavailable', (data) => {
      this.sendEvent(Connectivity.CONNECTIVITY_NONE)
    })

  }

  onCancel(args?: Object): void {
    Connectivity.netConnection.unregister((error) => {
    })
  }

  private sendEvent(networkType: String): Promise<void> {
    if (this.events != null && networkType != null) {
      this.events.success(networkType);
    }
    return new Promise((reject) => {
      reject();
    })
  }
}


