// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:device_info_plus_platform_interface/model/base_device_info.dart';

/// Object encapsulating Ohos device information.
class OhosDeviceInfo extends BaseDeviceInfo {
  /// Constructs a OhosDeviceInfo.
  OhosDeviceInfo._({
    required Map<String, dynamic> data,
    required this.deviceType,
    required this.manufacture,
    required this.brand,
    required this.marketName,
    required this.productSeries,
    required this.productModel,
    required this.softwareModel,
    required this.hardwareModel,
    required this.hardwareProfile,
    required this.serial,
    required this.bootloaderVersion,
    required this.abiList,
    required this.securityPatchTag,
    required this.displayVersion,
    required this.incrementalVersion,
    required this.osReleaseType,
    required this.osFullName,
    required this.majorVersion,
    required this.seniorVersion,
    required this.featureVersion,
    required this.buildVersion,
    required this.sdkApiVersion,
    required this.firstApiVersion,
    required this.versionId,
    required this.buildType,
    required this.buildUser,
    required this.buildHost,
    required this.buildTime,
    required this.buildRootHash,
    required this.udid,
    required this.distributionOSName,
    required this.distributionOSVersion,
    required this.distributionOSApiVersion,
    required this.distributionOSReleaseType,
  }) : super(data);

  final String? deviceType;
  final String? manufacture;
  final String? brand;
  final String? marketName;
  final String? productSeries;
  final String? productModel;
  final String? softwareModel;
  final String? hardwareModel;
  final String? hardwareProfile;
  final String? serial;
  final String? bootloaderVersion;
  final String? abiList;
  final String? securityPatchTag;
  final String? displayVersion;
  final String? incrementalVersion;
  final String? osReleaseType;
  final String? osFullName;
  final int? majorVersion;
  final int? seniorVersion;
  final int? featureVersion;
  final int? buildVersion;
  final int? sdkApiVersion;
  final int? firstApiVersion;
  final String? versionId;
  final String? buildType;
  final String? buildUser;
  final String? buildHost;
  final String? buildTime;
  final String? buildRootHash;
  final String? udid;
  final String? distributionOSName;
  final String? distributionOSVersion;
  final int? distributionOSApiVersion;
  final String? distributionOSReleaseType;

  /// Constructs a [OhosDeviceInfo] from a Map of dynamic.
  static OhosDeviceInfo fromMap(Map<String, dynamic> map) {
    return OhosDeviceInfo._(
      data: map,
      deviceType: map['deviceType'],
      manufacture: map['manufacture'],
      brand: map['brand'],
      marketName: map['marketName'],
      productSeries: map['productSeries'],
      productModel: map['productModel'],
      softwareModel: map['softwareModel'],
      hardwareModel: map['hardwareModel'],
      hardwareProfile: map['hardwareProfile'],
      serial: map['serial'],
      bootloaderVersion: map['bootloaderVersion'],
      abiList: map['abiList'],
      securityPatchTag: map['securityPatchTag'],
      displayVersion: map['displayVersion'],
      incrementalVersion: map['incrementalVersion'],
      osReleaseType: map['osReleaseType'],
      osFullName: map['osFullName'],
      majorVersion: map['majorVersion'],
      seniorVersion: map['seniorVersion'],
      featureVersion: map['featureVersion'],
      buildVersion: map['buildVersion'],
      sdkApiVersion: map['sdkApiVersion'],
      firstApiVersion: map['firstApiVersion'],
      versionId: map['versionId'],
      buildType: map['buildType'],
      buildUser: map['buildUser'],
      buildHost: map['buildHost'],
      buildTime: map['buildTime'],
      buildRootHash: map['buildRootHash'],
      udid: map['udid'],
      distributionOSName: map['distributionOSName'],
      distributionOSVersion: map['distributionOSVersion'],
      distributionOSApiVersion: map['distributionOSApiVersion'],
      distributionOSReleaseType: map['distributionOSReleaseType'],
    );
  }
}
