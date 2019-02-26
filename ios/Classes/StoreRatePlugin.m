#import "StoreRatePlugin.h"
#import <StoreKit/StoreKit.h>

@implementation StoreRatePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"plugin.persenlee.com/rate"
            binaryMessenger:[registrar messenger]];
  StoreRatePlugin* instance = [[StoreRatePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"rate" isEqualToString:call.method]) {
      NSString *type = call.arguments[@"type"];
      NSString *appId = call.arguments[@"appId"];
      if ([type isEqualToString:@"RateType.RateType2Store"]) {
          [self rate2Store:appId];
      } else if ([type isEqualToString:@"RateType.RateTypeInApp"]) {
          [self rateInApp:appId];
      }
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)rate2Store:(NSString *)appId
{
    NSString  *urlStr = [NSString  stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review",appId];
    NSURL *url = [NSURL URLWithString:urlStr];
    [[UIApplication sharedApplication] openURL:url];
}


- (void)rateInApp:(NSString *)appId
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
    } else {
        [self rate2Store:appId];
    }
}

@end
