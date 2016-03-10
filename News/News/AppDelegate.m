//
//  AppDelegate.m
//  News
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 马娟娟. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "WeiboSDK.h"
#import "WXApi.h"
#import <CoreLocation/CoreLocation.h>
#import <BmobSDK/BmobUser.h>
#import <BmobSDK/Bmob.h>
@interface AppDelegate ()<WeiboSDKDelegate,WXApiDelegate>
@property(nonatomic,strong)NSString *wbCurrentUserID;
@property(nonatomic,strong)NSString *wbRefreshToken;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
//    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UINavigationController *mainNav = mainSB.instantiateInitialViewController;
//    self.window.rootViewController = mainNav;
    
    MainViewController *mainVC = [[MainViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainVC];
    self.window.rootViewController = nav;
    
    //bmob
    [Bmob registerWithAppKey:kBmobAppKey];
    //微博
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    //微信
    [WXApi registerApp:kAppID];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WeiboSDK handleOpenURL:url delegate:self];
    return [WXApi handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
    return [WXApi handleOpenURL:url delegate:self];
}
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
}
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
