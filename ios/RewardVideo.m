//
//  RewardVideo.m
//
//  Created by ivan zhang on 2019/5/6.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTBridgeModule.h>

#import "RewardVideoViewController.h"
#import "BUDSlotViewModel.h"
#import "AdBoss.h"
#import <BUAdSDK/BUAdSDKManager.h>
#import <BUAdSDK/BURewardedVideoModel.h>


@interface RewardVideo : RCTEventEmitter <RCTBridgeModule>
{
  
}
@end

@implementation RewardVideo

RCT_EXPORT_MODULE();

static RCTEventEmitter* staticEventEmitter = nil;

+ (BOOL)requiresMainQueueSetup {
  return YES;
}


- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

-(id) init {
  self = [super init];
  if (self) {
    staticEventEmitter = self;
  }
  return self;
}

- (void)_sendEventWithName:(NSString *)eventName body:(id)body {
  if (staticEventEmitter == nil)
    return;
  [staticEventEmitter sendEventWithName:eventName body:body];
}

- (NSArray<NSString *> *)supportedEvents {
  return @[
           @"RewardVideo-adloaded",
           @"RewardVideo-videocached",
           @"RewardVideo-videoplayed",
           @"RewardVideo-adclick"
           ];
}


RCT_EXPORT_METHOD(loadAd:(NSDictionary *)options resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
{
  NSString *codeid = options[@"codeid"];
  if(codeid == nil) {
    return;
  }
  
  [AdBoss loadRewardAd:codeid userid:options[@"tt_uid"]];
  resolve(@"OK");
}

RCT_EXPORT_METHOD(startAd:(NSDictionary *)options resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
{
  NSString *codeid = options[@"codeid"];
  if(codeid == nil) {
    return;
  }
  
  //也许有缓存，先加载一下
//  [AdBoss loadRewardAd:codeid userid:options[@"tt_uid"]];
  
  RewardVideoViewController *vc = [RewardVideoViewController new];
  vc.view.backgroundColor = [UIColor whiteColor];
  
  UIViewController *rootVC = (UIViewController * )[UIApplication sharedApplication].delegate.window.rootViewController;
  [rootVC presentViewController:vc animated:true completion:^{
    
    [AdBoss saveResolve:resolve];
    [AdBoss saveReject:reject];
    
//    if([AdBoss getRewardVideoClicks] > 0)
//    {
//      resolve(@{
//        @"video_play":@1,
//        @"ad_click":@1,
//        @"verify_status":@0
//      });
//    } else {
//      resolve(@{
//        @"video_play":@1,
//        @"ad_click":@0,
//        @"verify_status":@0
//      });
//    }
  }];
  
}

@end

