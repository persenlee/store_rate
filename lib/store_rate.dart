import 'package:flutter/services.dart';

enum RateType{
  RateTypeInApp, //only support iOS(>10.0.3), system version < 10.0.3 use RateType2Store
  RateType2Store 
}


class StoreRate {
  static const MethodChannel _channel =
      const MethodChannel('plugin.persenlee.com/rate');

  static rate(RateType type,String appId) async {
    Map params = {'type' :type.toString()};
    if (appId !=null && appId.trim().length > 0) {
      params['appId'] =appId;
    }
    await _channel.invokeMethod('rate',params);
  }
}
