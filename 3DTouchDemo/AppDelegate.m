//
//  AppDelegate.m
//  3DTouchDemo
//
//  Created by 邱少依 on 16/4/8.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "AppDelegate.h"
#import "TestViewController111.h"
#import "TestViewController111.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //   设置标签数组
    [self setShortCutItems];
    return YES;
}

/** 创建shortcutItems */
- (void)setShortCutItems {
    NSMutableArray *shortcutItems = [NSMutableArray array];
    NSArray *iconArray = @[@"mobileMoney",@"oilMoney",@"result_none"];
    NSArray *titleArray = @[@"手机充值",@"加油卡充值",@"维他医生"];
    for (NSInteger i =0; i<3; ++i) {
        UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithTemplateImageName:iconArray[i]];
        UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc]initWithType:[NSString stringWithFormat:@"%ld",(long)i] localizedTitle:titleArray[i] localizedSubtitle:nil icon:icon userInfo:nil];
        [shortcutItems addObject:item];
    }
    [[UIApplication sharedApplication] setShortcutItems:shortcutItems];
}

//检测是从点击app图标还是从touch进入app
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    Class cls;
    UIViewController *pushVC;
    UIViewController *viewController = [self getCurrentVC];
    switch (shortcutItem.type.integerValue) {
        case 0:
        { // 手机充值
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoJumpViewController" object:self userInfo:@{@"type":@"0"}];
            // 获取到当前已经在活跃的导航控制器
            cls = NSClassFromString(@"Test111_FirstViewController");
            pushVC = [[cls alloc]init];
           
        }  break;
            
        case 1: { // 加油卡充值
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoJumpViewController" object:self userInfo:@{@"type":@"1"}];
            cls = NSClassFromString(@"Test111_SecondViewController");
            pushVC = [[cls alloc]init];
            
        }   break;
            
        case 2: { // 医生
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoJumpViewController" object:self userInfo:@{@"type":@"2"}];
             cls = NSClassFromString(@"Test111_ThirdViewController");
            pushVC = [[cls alloc]init];
            
        }   break;
        case 3: { // 测试1
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoJumpViewController" object:self userInfo:@{@"type":@"2"}];
        }   break;
        default:
            break;
    }
    pushVC.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:pushVC animated:YES];
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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
