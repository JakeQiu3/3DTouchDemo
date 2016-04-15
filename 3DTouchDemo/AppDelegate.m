//
//  AppDelegate.m
//  3DTouchDemo
//
//  Created by 邱少依 on 16/4/8.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TestViewController111.h"
#import "Test111_FirstViewController.h"
#import "Test111_SecondViewController.h"
#import "Test111_ThirdViewController.h"
@interface AppDelegate ()
{
     NSInteger loginSelectItem; // 登录时：0不做操作， 1:跳转手机充值 2:跳转加油卡充值
}
@end
//3dTouch 的网址 http://my.oschina.net/u/2340880/blog/511509#OSC_h4_4
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setShortCutItems];
    [self loadRootViewController];
    return YES;
}
/** 创建shortcutItems */
- (void)setShortCutItems {
    NSMutableArray *shortcutItems = [NSMutableArray array];
    NSArray *iconArray = @[@"mobileMoney",@"oilMoney",@"result_none"];
    NSArray *titleArray = @[@"手机充值",@"加油卡充值",@"维他医生"];
    for (NSInteger i =0; i<3; ++i) {
        UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithTemplateImageName:iconArray[i]];
        UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc]initWithType:[NSString stringWithFormat:@"%ld",(long)i+1] localizedTitle:titleArray[i] localizedSubtitle:nil icon:icon userInfo:nil];
        if (!icon && !item ) {//判断API
            return;
        }
        [shortcutItems addObject:item];
    }
    [[UIApplication sharedApplication] setShortcutItems:shortcutItems];
}
//加载根视图
- (void)loadRootViewController {
//    UIViewController *rootViewController;
//    if (isLogin) {//是否登录
        //    LoginViewController *loginView = [[LoginViewController alloc]init];
        //    rootViewController = loginView;
        // } else {
//    TestViewController111 *testView = [[TestViewController111 alloc]init];
//    rootViewController = testView;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (!loginSelectItem) {
//            [self pushShortcutViewController:loginSelectItem];
//            loginSelectItem = 0;
//        }
//        
//    });
//}
//    self.window.rootViewController = rootViewController;
        //    已经登录
}
//检测是从点击app图标还是从touch进入app
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
////    if (isLogin) {//是否登录
//    LoginViewController *loginView = [[LoginViewController alloc]init];
//    self.window.rootViewController = loginView;
//    loginSelectItem = shortcutItem.type.integerValue;
//    return;//交互完后，再调用下面的这个方法，进行跳转
////    }
//    已经登录
     [self pushShortcutViewController:shortcutItem.type.integerValue];
}

- (void)pushShortcutViewController:(NSInteger )selectedItemNum {

    Class cls;
    UIViewController *pushVC;
    UIViewController *topVC = [self topViewController];
    switch (selectedItemNum) {
        case 0: { // 测试1  info.plist中
            
        }   break;
            
        case 1:
        { // 手机充值
            if ([topVC.navigationController.topViewController isKindOfClass:[Test111_FirstViewController class]]) {//判断是否已经入栈
                return;
            }
            // 获取到当前已经在活跃的导航控制器
            cls = NSClassFromString(@"Test111_FirstViewController");
            pushVC = [[cls alloc]init];
            
        }  break;
            
        case 2: { // 加油卡充值
            if ([topVC.navigationController.topViewController isKindOfClass:[Test111_SecondViewController class]]) {//判断是否已经入栈
                return;
            }
            cls = NSClassFromString(@"Test111_SecondViewController");
            pushVC = [[cls alloc]init];
            
        }   break;
            
        case 3: { // 医生
            if ([topVC.navigationController.topViewController isKindOfClass:[Test111_ThirdViewController class]]) {//判断是否已经入栈
                return;
            }
            cls = NSClassFromString(@"Test111_ThirdViewController");
            pushVC = [[cls alloc]init];
            
        }   break;
            
            
        default:
            break;
    }
    pushVC.hidesBottomBarWhenPushed = YES;
    [topVC.navigationController pushViewController:pushVC animated:YES];
}

//获取到当前屏幕显示最顶上的UIViewController
- (UIViewController*)topViewController
{
    return [self topViewControllerWithRootViewController:self.window.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
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
