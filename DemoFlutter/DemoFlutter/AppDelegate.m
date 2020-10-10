//
//  AppDelegate.m
//  DemoFlutter
//
//  Created by  joy on 2020/7/8.
//  Copyright © 2020  joy. All rights reserved.
//

#import "AppDelegate.h"
#import <flutter_boost/FlutterBoost.h>

@interface AppDelegate ()<FLBPlatform>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [FlutterBoostPlugin.sharedInstance startFlutterWithPlatform:self onStart:^(FlutterEngine *engine) {
        
    }];
    
    [FlutterBoostPlugin.sharedInstance addEventListener:^(NSString *name, NSDictionary *arguments) {
    
          
      } forName:@"sssss"];
    

    return YES;
}

- (NSString *)entryForDart
{
    
    
    return nil;
}
/**
 * 基于Native平台实现页面打开，Dart层的页面打开能力依赖于这个函数实现；Native或者Dart侧不建议直接使用这个函数。应直接使用FlutterBoost封装的函数
 *
 * @param url 打开的页面资源定位符
 * @param urlParams 传人页面的参数; 若有特殊逻辑，可以通过这个参数设置回调的id
 * @param exts 额外参数
 * @param completion 打开页面的即时回调，页面一旦打开即回调
 */
- (void)open:(NSString *)name
   urlParams:(NSDictionary *)params
        exts:(NSDictionary *)exts
      completion:(void (^)(BOOL finished))completion
{
    self.window = [UIApplication sharedApplication].keyWindow;
    
    BOOL animated = [exts[@"animated"] boolValue];
    FLBFlutterViewContainer *vc = FLBFlutterViewContainer.new;
    [vc setName:name params:params];
    UINavigationController *nav;
    if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
        nav = (id)self.window.rootViewController;
    }
    [nav pushViewController:vc animated:animated];
    if(completion) completion(YES);
}

/**
 * 基于Native平台实现present页面打开，Dart层的页面打开能力依赖于这个函数实现；Native或者Dart侧不建议直接使用这个函数。应直接使用FlutterBoost封装的函数
 *
 * @param url 打开的页面资源定位符
 * @param urlParams 传人页面的参数; 若有特殊逻辑，可以通过这个参数设置回调的id
 * @param exts 额外参数
 * @param completion 打开页面的即时回调，页面一旦打开即回调
 */
- (void)present:(NSString *)url
   urlParams:(NSDictionary *)urlParams
        exts:(NSDictionary *)exts
  completion:(void (^)(BOOL finished))completion
{
    
}

/**
 * 基于Native平台实现页面关闭，Dart层的页面关闭能力依赖于这个函数实现；Native或者Dart侧不建议直接使用这个函数。应直接使用FlutterBoost封装的函数
 *
 * @param uid 关闭的页面唯一ID符
 * @param result 页面要返回的结果（给上一个页面），会作为页面返回函数的回调参数
 * @param exts 额外参数
 * @param completion 关闭页面的即时回调，页面一旦关闭即回调
 */
- (void)close:(NSString *)uid
       result:(NSDictionary *)result
         exts:(NSDictionary *)exts
   completion:(void (^)(BOOL finished))completion
{
    
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
