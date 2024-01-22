//导包
import connection from '@ohos.net.connection'

//创建tag
const TAG = "Connectivity";

//创建类
export class Connectivity {
  public static CONNECTIVITY_NONE = "none";
  private static CONNECTIVITY_WIFI = "wifi";
  private static CONNECTIVITY_MOBILE = "mobile";
  private static CONNECTIVITY_ETHERNET = "ethernet";
  private static CONNECTIVITY_BLUETOOTH = "bluetooth";
  private static CONNECTIVITY_VPN = "vpn";
  public static netConnection = connection.createNetConnection();
  public networkType: String = Connectivity.CONNECTIVITY_NONE;

  constructor() {

  }


  getNetworkType(): String {
    //通过异步方式获取网络信息
    connection.getDefaultNet().then((netHandle) => {
      connection.getNetCapabilities(netHandle).then((capabilities) => {
        this.networkType = this.hasTransport(capabilities.bearerTypes);
      });
    })
    return this.networkType;
  }

  hasTransport(capabilities: Array<number>): String {
    //若数组为空返回CONNECTIVITY_NONE
    if (capabilities.length == 0) {
      return Connectivity.CONNECTIVITY_NONE;
    }
    if (capabilities.includes(connection.NetBearType.BEARER_WIFI)) {
      return Connectivity.CONNECTIVITY_WIFI;
    }
    if (capabilities.includes(connection.NetBearType.BEARER_ETHERNET)) {
      return Connectivity.CONNECTIVITY_ETHERNET;
    }
    if (capabilities.includes(connection.NetBearType.BEARER_CELLULAR)) {
      return Connectivity.CONNECTIVITY_MOBILE;
    }

    return Connectivity.CONNECTIVITY_NONE;
  }
}



