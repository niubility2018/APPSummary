//
//  AppDelegate.m
//  APPSummary
//
//  Created by xubojoy on 2018/2/23.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "AppDelegate.h"
#import <JPFPSStatus/JPFPSStatus.h>
#import "UIColor+Random.h"
#import "APPSummaryTabbarController.h"
#import <JxbDebugTool.h>
#import "AdvertiseHelper.h"
#import "GSKeyChainDataManager.h"
#if DEBUG
#import <FLEX/FLEX.h>
#endif
#import "LXDAppFluencyMonitor.h"
#import "LXDFPSMonitor.h"
#import "LXDResourceMonitor.h"
#import "LXDCrashMonitor.h"
#import <Bugly/Bugly.h>
#import "IQKeyboardManager.h"
#import "NSData+CRC32.h"


NSString * key = @"XDZzB7SNUeJOi90vPtl9i1PT8VxUKCr3M7IKCAiluw1FvWqeolmFUhT0qjTKyplvKYlFPvECMd7Cf0yQUHeIWOu9sbrrMPx78yneExR00MPvCf9707KFMp7lndO9XFWO0d0Un6ztL4a3GfwWD0hzeL5qURQNhC8oZR7UqDt5GMtMvHVhRuO97HhC7wnEglJ9jdU1Wzq7";


@interface AppDelegate ()

@end

@implementation AppDelegate
- (UIWindow *)window
{
    if(!_window)
    {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor RandomColor];
        [_window makeKeyAndVisible];
    }
    return _window;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    self.window.rootViewController = [[APPSummaryTabbarController alloc] init];
    
    NSString *deviceUUID = [[UIDevice currentDevice].identifierForVendor UUIDString];
    
    [GSKeyChainDataManager saveUUID:deviceUUID];
    
    NSLog(@"%@",[GSKeyChainDataManager readUUID]);
    
    NSArray <NSString *> *imagesURLS = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495189872684&di=03f9df0b71bb536223236235515cf227&imgtype=0&src=http%3A%2F%2Fatt1.dzwww.com%2Fforum%2F201405%2F29%2F1033545qqmieznviecgdmm.gif", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495189851096&di=224fad7f17468c2cc080221dd78a4abf&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201505%2F12%2F20150512124019_GPjEJ.gif"];
    // 启动广告
    [AdvertiseHelper showAdvertiserView:imagesURLS];
    
    
    [FLUENCYMONITOR startMonitoring];
    [FPS_MONITOR startMonitoring];
    [RESOURCE_MONITOR startMonitoring];
    [LXDCrashMonitor startMonitoring];
    
    [Bugly startWithAppId:@"fd8a6049ce"];
    
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarByPosition];
    
//#if defined(DEBUG)||defined(_DEBUG)
//    [[JPFPSStatus sharedInstance] open];
//#endif
    
//#if DEBUG
//    [[FLEXManager sharedManager] setNetworkDebuggingEnabled:YES];
//#endif
    
    //后台播放
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session  setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    [application beginReceivingRemoteControlEvents];//开启接收远程事件
    

    if (![easyar_Engine initialize:key]) {
        NSLog(@"Initialization Failed.");
    }
    
#if DEBUG
    [[JxbDebugTool shareInstance] setMainColor:[UIColor redColor]]; //设置主色调
    [[JxbDebugTool shareInstance] enableDebugMode];//启用debug工具
#endif
    return YES;
}

#pragma mark - 接收远程事件
-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPause://暂停
            {
                [[LZPlayerManager lzPlayerManager] playAndPause];
                [LZPlayerBottomView lzPlayerBottomView].isSongPlayer = NO;
                break;
            }case UIEventSubtypeRemoteControlPlay://播放
            {
                [[LZPlayerManager lzPlayerManager] playAndPause];
                [LZPlayerBottomView lzPlayerBottomView].isSongPlayer = YES;
                break;
            }case UIEventSubtypeRemoteControlPreviousTrack://前一首
            {
                [[LZPlayerManager lzPlayerManager]playPrevious];
                [[LZPlayerBottomView lzPlayerBottomView] reloadDataWithIndex: [LZPlayerManager lzPlayerManager].index];
                break;
            }case UIEventSubtypeRemoteControlNextTrack://下一首
            {
                [[LZPlayerManager lzPlayerManager]playNext];
                [[LZPlayerBottomView lzPlayerBottomView] reloadDataWithIndex: [LZPlayerManager lzPlayerManager].index];
                break;
            }
            default:
                break;
        }
    }
}



- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // 获取各种数据
    NSMutableData *sendData = [[NSMutableData alloc] initWithData:deviceToken];
    int32_t checksum = [deviceToken crc32];
    int32_t swapped = CFSwapInt32LittleToHost(checksum);
    char *a = (char*) &swapped;
    [sendData appendBytes:a length:sizeof(4)];
    
    //检验
    //    Byte *b1 = (Byte *)[sendData bytes];
    //    for (int i = 0; i < sendData.length; i++) {
    //        NSLog(@"b1[%d] == %d",i,b1[i]);
    //    }
    NSString *device_token_crc32 = [sendData base64EncodedStringWithOptions:0];
    //    NSLog(@"b1:%@",[sendData base64EncodedStringWithOptions:0]);
    //保存获取到的数据
    NSString *device_token = [NSString stringWithFormat:@"%@",deviceToken];
    [[NSUserDefaults standardUserDefaults]setObject:device_token forKey:@"device_token"];
    [[NSUserDefaults standardUserDefaults]setObject:device_token_crc32 forKey:@"device_token_crc32"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    //    NSLog(@"deviceToken---------------》%@", deviceToken);
    //    NSLog(@"device_token--------------》%@", device_token);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    [easyar_Engine onPause];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [easyar_Engine onResume];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
