import { MethodCall } from '@ohos/flutter_ohos';
import { MethodCallHandler, MethodResult } from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodChannel';
import Share from './Share';
import { defaultAppManager } from '@kit.AbilityKit';

export default class MethodCallHandlerImpl implements MethodCallHandler {
  private share: Share | null = null

  constructor(share: Share) {
    this.share = share
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    const isWithResult = call.method.endsWith('WithResult')
    switch (call.method) {
      case 'shareUri':
        this.share?.share(call.argument('uri') as string, null, false, result)
        if (!isWithResult) {
          result.success(null)
        }
        break
      case 'share':
      case 'shareWithResult':
        this.share?.share(
          call.argument('text') as string,
          call.argument('subject') as string,
          isWithResult, result)
        if (!isWithResult) {
          result.success("dev.fluttercommunity.plus/share/unavailable")
        }
        break
      case 'shareFiles':
      case 'shareFilesWithResult':
        this.share?.shareFiles(
          call.argument('paths'),
          call.argument('mimeTypes'),
          call.argument('text'),
          call.argument('subject'),
          isWithResult, result)
        if (!isWithResult) {
          result.success("dev.fluttercommunity.plus/share/unavailable")
        }
        break
      default:
        result.notImplemented();
        break;
    }
  }
}
