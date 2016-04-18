//
//  Test3DTouchViewController.m
//  TouchNewAPI
//
//  Created by qsy on 15/12/2.
//  Copyright © 2015年 qsy. All rights reserved.
//

#import "Test3DTouchViewController.h"
#import "PViewController.h"
#import "AppDelegate.h"

@interface Test3DTouchViewController ()

@end

@implementation Test3DTouchViewController

- (instancetype)initWithTitle:(NSString *)title bgColor:(UIColor *)bgc
{
    if (self = [super init]) {
        self.title = title;
        self.view.backgroundColor = bgc;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction * action1 = [UIPreviewAction actionWithTitle:@"邱少" style:1 handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {

        PViewController *aaaa = [[PViewController alloc] init];
        aaaa.view.backgroundColor = [UIColor orangeColor];
        [[self topViewController].navigationController pushViewController:aaaa animated:YES];
    }];

    UIPreviewAction * action2 = [UIPreviewAction actionWithTitle:@"丑" style:0 handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        UIViewController *aaaa = [[UIViewController alloc] init];
        aaaa.view.backgroundColor = [UIColor brownColor];
        [[self topViewController].navigationController pushViewController:aaaa animated:YES];

    }];
    UIPreviewAction * action3 = [UIPreviewAction actionWithTitle:@"顶楼上" style:2 handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
    }];

    NSArray * actions = @[action1,action2,action3];

    return actions;
}

- (UIViewController*)topViewController
{
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
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

@end
