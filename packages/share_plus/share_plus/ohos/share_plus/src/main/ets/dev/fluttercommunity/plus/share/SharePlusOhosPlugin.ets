/*
* Copyright (c) 2023 Hunan OpenValley Digital Industry Development Co., Ltd.
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

import AbilityAware from '@ohos/flutter_ohos/src/main/ets/embedding/engine/plugins/ability/AbilityAware';
import {
  AbilityPluginBinding
} from '@ohos/flutter_ohos/src/main/ets/embedding/engine/plugins/ability/AbilityPluginBinding';
import { FlutterPlugin,
  FlutterPluginBinding } from '@ohos/flutter_ohos/src/main/ets/embedding/engine/plugins/FlutterPlugin';

const TAG = "SharePlusOhosPlugin";
const CHANNEL_NAME = 'dev.fluttercommunity.plus/share_info';

export default class SharePlusOhosPlugin implements FlutterPlugin, AbilityAware {
  private abilityPluginBinding: AbilityPluginBinding | null = null;

  getUniqueClassName(): string {
    return TAG;
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    throw new Error('Method not implemented.');
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    throw new Error('Method not implemented.');
  }

  onAttachedToAbility(binding: AbilityPluginBinding): void {
    throw new Error('Method not implemented.');
  }

  onDetachedFromAbility(): void {
    throw new Error('Method not implemented.');
  }

}
