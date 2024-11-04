/*
 * Copyright (C) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import {
  BinaryMessenger,
  FlutterPlugin,
  FlutterPluginBinding,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
  EventChannel,
} from '@ohos/flutter_ohos';
import { EventSink, StreamHandler } from '@ohos/flutter_ohos/src/main/ets/plugin/common/EventChannel';
import { sensor } from '@kit.SensorServiceKit';
import { BusinessError } from '@kit.BasicServicesKit';

// StreamHandlerImpl 实现了 StreamHandler 接口
class StreamHandlerImpl implements StreamHandler {
  private event?: EventSink;
  private sensorId?: sensor.SensorId;

  constructor(sensorId: sensor.SensorId) {
    this.sensorId = sensorId;
    this.initSensorData();
  }

  private initSensorData(): void {
    switch (this.sensorId) {
      case sensor.SensorId.LINEAR_ACCELEROMETER:
        this.listenLinearAccelerometer();
        break;
      case sensor.SensorId.GYROSCOPE:
        this.listenGyroscope();
        break;
      case sensor.SensorId.ACCELEROMETER:
        this.listenAccelerometer();
        break;
      case sensor.SensorId.MAGNETIC_FIELD:
        this.listenMagnetic();
        break;
    }
  }

  // user加速度计传感器
  private listenLinearAccelerometer(): void {
    try {
      sensor.on(sensor.SensorId.LINEAR_ACCELEROMETER, (data: sensor.LinearAccelerometerResponse) => {
        if (this.event) {
          let arr: Array<number> = [3];
          arr[0] = data.x;
          arr[1] = data.y;
          arr[2] = data.z;
          if (Number.isInteger(data.x)) {
            arr[0] = data.x + 0.00000000001;
          }
          if (Number.isInteger(data.y)) {
            arr[1] = data.y + 0.00000000001;
          }
          if (Number.isInteger(data.z)) {
            arr[2] = data.z + 0.00000000001;
          }
          this.event.success(arr);
        }
      }, { interval: 100000000 });
    } catch (error) {
      let e: BusinessError = error as BusinessError;
      console.error(`Failed to invoke on. Code: ${e.code}, message: ${e.message}`);
    }
  }

  // 陀螺仪
  private listenGyroscope(): void {
    try {
      sensor.on(sensor.SensorId.GYROSCOPE, (data: sensor.GyroscopeResponse) => {
        if (this.event) {
          let arr: Array<number> = [3];
          arr[0] = data.x;
          arr[1] = data.y;
          arr[2] = data.z;
          if (Number.isInteger(data.x)) {
            arr[0] = data.x + 0.00000000001;
          }
          if (Number.isInteger(data.y)) {
            arr[1] = data.y + 0.00000000001;
          }
          if (Number.isInteger(data.z)) {
            arr[2] = data.z + 0.00000000001;
          }
          this.event.success(arr);
        }
      }, { interval: 100000000 });
    } catch (error) {
      let e: BusinessError = error as BusinessError;
      console.error(`Failed to invoke on. Code: ${e.code}, message: ${e.message}`);
    }
  }

  // 加速度计
  private listenAccelerometer(): void {
    try {
      sensor.on(sensor.SensorId.ACCELEROMETER, (data: sensor.AccelerometerResponse) => {
        if (this.event) {
          let arr: Array<number> = [3];
          arr[0] = data.x;
          arr[1] = data.y;
          arr[2] = data.z;
          if (Number.isInteger(data.x)) {
            arr[0] = data.x + 0.00000000001;
          }
          if (Number.isInteger(data.y)) {
            arr[1] = data.y + 0.00000000001;
          }
          if (Number.isInteger(data.z)) {
            arr[2] = data.z + 0.00000000001;
          }
          this.event.success(arr);
        }
      }, { interval: 100000000 });
    } catch (error) {
      let e: BusinessError = error as BusinessError;
      console.error(`Failed to invoke on. Code: ${e.code}, message: ${e.message}`);
    }
  }

  // 磁力计
  private listenMagnetic(): void {
    try {
      sensor.on(sensor.SensorId.MAGNETIC_FIELD, (data: sensor.MagneticFieldResponse) => {
        if (this.event) {
          let arr: Array<number> = [3];
          arr[0] = data.x;
          arr[1] = data.y;
          arr[2] = data.z;
          if (Number.isInteger(data.x)) {
            arr[0] = data.x + 0.00000000001;
          }
          if (Number.isInteger(data.y)) {
            arr[1] = data.y + 0.00000000001;
          }
          if (Number.isInteger(data.z)) {
            arr[2] = data.z + 0.00000000001;
          }
          this.event.success(arr);
        }
      }, { interval: 100000000 });
    } catch (error) {
      let e: BusinessError = error as BusinessError;
      console.error(`Failed to invoke on. Code: ${e.code}, message: ${e.message}`);
    }
  }

  onListen(args: ESObject, events: EventSink): void {
    this.event = events;
  }

  onCancel(args: ESObject): void {
  }
}

/** SensorsPlusOhosPlugin **/
export default class SensorsPlusOhosPlugin implements FlutterPlugin, MethodCallHandler {
  private channel: MethodChannel | null = null;
  private ACCELEROMETER_CHANNEL_NAME: string = "dev.fluttercommunity.plus/sensors/accelerometer";
  private GYROSCOPE_CHANNEL_NAME: string = "dev.fluttercommunity.plus/sensors/gyroscope";
  private MAGNETOMETER_CHANNEL_NAME: string = "dev.fluttercommunity.plus/sensors/magnetometer";
  private USER_ACCELEROMETER_CHANNEL_NAME: string = "dev.fluttercommunity.plus/sensors/user_accel";

  constructor() {
  }

  getUniqueClassName(): string {
    return "SensorsPlusOhosPlugin";
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.channel = new MethodChannel(binding.getBinaryMessenger(), "dev.fluttercommunity.plus/sensors/method");
    this.channel.setMethodCallHandler(this);
    this.setupEventChannels(binding.getApplicationContext(), binding.getBinaryMessenger());
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel != null) {
      this.channel.setMethodCallHandler(null);
    }
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    if (call.method == "getPlatformVersion") {
      result.success("OpenHarmony ^ ^ ")
    } else {
      result.notImplemented();
    }
  }

  private setupEventChannels(context: Context, messenger: BinaryMessenger) {
    // user加速度计
    let userAccelerometerChannel = new EventChannel(messenger, this.USER_ACCELEROMETER_CHANNEL_NAME);
    let userAccelerationStreamHandler = new StreamHandlerImpl(sensor.SensorId.LINEAR_ACCELEROMETER);
    userAccelerometerChannel.setStreamHandler(userAccelerationStreamHandler);

    // 陀螺仪
    let gyroscopeChannel = new EventChannel(messenger, this.GYROSCOPE_CHANNEL_NAME);
    let gyroScopeStreamHandler = new StreamHandlerImpl(sensor.SensorId.GYROSCOPE);
    gyroscopeChannel.setStreamHandler(gyroScopeStreamHandler);

    // 加速度计
    let accelerometerChannel = new EventChannel(messenger, this.ACCELEROMETER_CHANNEL_NAME);
    let accelerationStreamHandler = new StreamHandlerImpl(sensor.SensorId.ACCELEROMETER);
    accelerometerChannel.setStreamHandler(accelerationStreamHandler);

    // 磁力计
    let magnetometerChannel = new EventChannel(messenger, this.MAGNETOMETER_CHANNEL_NAME);
    let magnetometerStreamHandler = new StreamHandlerImpl(sensor.SensorId.MAGNETIC_FIELD);
    magnetometerChannel.setStreamHandler(magnetometerStreamHandler);
  }
}
