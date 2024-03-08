import common from '@ohos.app.ability.common'
import UIAbility from '@ohos.app.ability.UIAbility';
import list from '@ohos.util.List';
import ArrayList from '@ohos.util.ArrayList';
import fs from '@ohos.file.fs';
import { fileUri } from '@kit.CoreFileKit';
import { MethodResult } from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodChannel';
import Want from '@ohos.app.ability.Want';;
import wantConstant from '@ohos.app.ability.wantConstant';

export default class Share {
  public context: common.Context | null = null;
  public ability?: UIAbility | null = null;

  constructor(context: common.Context, ability?: UIAbility) {
    this.context = context
    this.ability = ability
  }

  public setAbility(ability: UIAbility | null): void {
    this.ability = ability
  }

  private shareCacheFolder(): string {
    return this.context?.cacheDir + '/share_plus';
  }

  public async share(text: string, subject: string | null, withResult: boolean, result: MethodResult): Promise<void> {
    let want: Want = {
      flags: wantConstant.Flags.FLAG_AUTH_WRITE_URI_PERMISSION | wantConstant.Flags.FLAG_AUTH_READ_URI_PERMISSION,
      action: 'ohos.want.action.sendData',
      parameters: {
        'text': text,
        'subject': subject!
      }
    }
    await this.startAbility(want, withResult)
  }

  public async shareFiles(paths: List<string>, mimeTypes: List<string> | null, text: string, subject: string | null, withResult: boolean, result: MethodResult): Promise<void> {
    this.clearShareCacheFolder()
    let fileUris = await this.getUrisForPaths(paths)
    let want: Want;
    if (fileUris.length == 0 && text.length !== 0) {
      this.share(text, subject, withResult, result)
      return
    } else if (fileUris.length == 1) {
      let mimeType: string;
      if (mimeTypes && mimeTypes.length != 0) {
        mimeType = mimeTypes[0]
      } else {
        mimeType = "*/*"
      }
      want = {
        flags: wantConstant.Flags.FLAG_AUTH_WRITE_URI_PERMISSION | wantConstant.Flags.FLAG_AUTH_READ_URI_PERMISSION,
        action: 'ohos.want.action.sendData',
        type: mimeType,
        uri: fileUris[0],
        parameters: {
          'text': text,
          'subject': subject!
        }
      }
    } else {
      //   TODO: 分享多个文件
      want = {
        flags: wantConstant.Flags.FLAG_AUTH_WRITE_URI_PERMISSION | wantConstant.Flags.FLAG_AUTH_READ_URI_PERMISSION,
        action: 'ohos.want.action.sendData',
        type: this.reduceMimeTypes(mimeTypes),
        // uri: fileUris,
        parameters: {
          'text': text,
          'subject': subject!
        }
      }
    }
    await this.startAbility(want, withResult, result)
  }

  public async startAbility(want: Want, withResult: boolean, result?: MethodResult): Promise<void> {
    if (this.ability != null) {
      if (withResult) {
        let abilityResult = await this.ability?.context.startAbilityForResult(want);
        let resultWant = abilityResult?.want
        result?.success(`${resultWant?.bundleName}/${resultWant?.abilityName}`)
      } else {
        await this.ability?.context?.startAbility(want);
      }
    } else {
      //   TODO
    }
  }

  private async getUrisForPaths(paths: list<string>): Promise<ArrayList<string>> {
    let uris = new ArrayList<string>()
    paths.forEach(async path => {
      let file: string;
      //   TODO
      if (this.fileIsInShareCache(path)) {
        throw new Error(`Shared file can not be located in '${this.shareCacheFolder()}`)
      }
      file = await this.copyToShareCacheFolder(path)
      uris.add(fileUri.getUriFromPath(file))
    })
    return uris
  }

  public fileIsInShareCache(file: string): boolean {
    return false
  }

  private reduceMimeTypes(mimeTypes: list<string> | null): string {
    if (mimeTypes == null) {
      return "*/*"
    }
    if (mimeTypes != null && mimeTypes.length == 1) {
      return mimeTypes[0]
    }
    let commonMimeType: string = mimeTypes && mimeTypes[0]
    for (let i = 0; i < mimeTypes.length; i++) {
      if (commonMimeType != mimeTypes[i]) {
        if (this.getMimeTypeBase(commonMimeType) == this.getMimeTypeBase(mimeTypes[i])) {
          commonMimeType = this.getMimeTypeBase(mimeTypes[i] + "/*")
        } else {
          commonMimeType = "*/*"
          break
        }
      }
    }
    return commonMimeType
  }

  private getMimeTypeBase(mimeType: string): string {
    if (mimeType == null || !mimeType.includes('/')) {
      return "*"
    } else {
      return mimeType.substring(0, mimeType.indexOf("/"))
    }
  }

  private async clearShareCacheFolder(): Promise<void> {
    let folder: string = this.shareCacheFolder()
    if (fs.accessSync(folder)) {
      let files = fs.listFileSync(folder)
      if (files.length > 0) {
        files.forEach(item => {
          fs.unlinkSync(folder + '/' + item)
        })
        fs.rmdirSync(folder)
      }
    }
  }

  private async copyToShareCacheFolder(file: string): Promise<string> {
    let folder = this.shareCacheFolder()
    if (!fs.accessSync(folder)) {
      fs.mkdirSync(folder)
    }
    let oldFile: fs.File = fs.openSync(file);
    let newFile = folder + '/' + oldFile.name
    fs.copyFileSync(oldFile.fd, newFile)
    return newFile
  }
}
