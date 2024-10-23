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
  FlutterPlugin,
  FlutterPluginBinding,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
} from '@ohos/flutter_ohos';

import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';
import abilityAccessCtrl from '@ohos.abilityAccessCtrl';

let TAG = "ScreenProtectorOhosPlugin";
let windowClass: window.Window | undefined = undefined;
let isPrivacyMode: boolean = true //true表示模式开启；false表示模式关闭。

/** ScreenProtectorOhosPlugin **/
export default class ScreenProtectorOhosPlugin implements FlutterPlugin, MethodCallHandler {
  private channel: MethodChannel | null = null;
  private atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();

  constructor() {
  }

  getUniqueClassName(): string {
    return "ScreenProtectorOhosPlugin"
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.channel = new MethodChannel(binding.getBinaryMessenger(), "screen_protector_ohos");
    this.channel.setMethodCallHandler(this)
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel != null) {
      this.channel.setMethodCallHandler(null)
    }
  }

  async onMethodCall(call: MethodCall, result: MethodResult): Promise<void> {
    switch (call.method) {
      case "protectDataLeakageOn":
      case "preventScreenshotOn":
        isPrivacyMode = true
        break;
      case "protectDataLeakageOff":
      case "preventScreenshotOff":
        isPrivacyMode = false
        break;
      default:
        break;
    }

    this.atManager.requestPermissionsFromUser(getContext(this), ['ohos.permission.PRIVACY_WINDOW'])
      .then(async (permission) => {
        if (permission.authResults[0] !== 0) {
          result.success(false)
          console.error(TAG, "Failed apply the ohos.permission.PRIVACY_WINDOW permission");
        } else {
          if (windowClass == null) {
            windowClass = await window.getLastWindow(getContext(this));
          }
          try {
            windowClass.setWindowPrivacyMode(isPrivacyMode, (err: BusinessError) => {
              const errCode: number = err.code;
              if (errCode) {
                console.error(TAG, `Failed to set the window to privacy mode`);
                result.success(false)
                return
              }
              result.success(true)
            });
          } catch (exception) {
            result.success(false)
            console.error(TAG, `Failed to set the window to privacy mode`);
          }
        }
      });
  }
}