//
//  UIView+GetViewController.m
//  VinuxPost
//
//  Created by 邱少依 on 16/4/8.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "UIView+GetViewController.h"

@implementation UIView (GetViewController)

- (UIViewController *)parentController {
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

+ (UIViewController *)getCurrentViewController
{
    //    UIWindow(keyWindow)—>UITransitionView{包括：tabbarViewcontroller或者导航控制器，或者普通控制器}
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // modal展现方式的底层视图不同
    // 取到第1层时，取到的是UITransitionView，通过这个view拿不到控制器
    UIView *firstView = [keyWindow.subviews firstObject];
    UIView *secondView = [firstView.subviews firstObject];
    UIViewController *vc = secondView.parentController;
    if ([vc isKindOfClass:[UITabBarController class]]) {//若是tabbarViewController
        UITabBarController *tab = (UITabBarController *)vc;
        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
            return [nav.viewControllers lastObject];
        } else {
            return tab.selectedViewController;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.viewControllers lastObject];
    } else {
        return vc;
    }
    return nil;
}

@end
