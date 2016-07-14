//
//  Tools.m
//  517job
//
//  Created by noci on 16/4/22.
//  Copyright © 2016年 eTao. All rights reserved.
//

#import "Tools.h"

//#import "BaseTabBarViewController.h"
//#import "BaseNaviViewController.h"

@implementation Tools

+(UIViewController *)getCurrentViewController
{
    //首先。拿到根windows。
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    //然后。拿到根vc.
    UIViewController * rootVC = window.rootViewController;
    //真实根视图。
    
    while (![rootVC isEqual:[self getCurrentPresentViewController:rootVC]]) {
        
        rootVC = [self getCurrentPresentViewController:rootVC];
    }
    
    //判断根视图
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController * tabbar = (UITabBarController *)rootVC;
        //当前选中的bar.
        UIViewController * choosedVC = tabbar.selectedViewController;
        
        if ([choosedVC isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController * currentNavi = (UINavigationController *)choosedVC;
            return currentNavi.visibleViewController;
            
        }
        else if ([choosedVC isKindOfClass:[UIViewController class]])
        {
            return choosedVC;
        }
        
    }
    else if ([rootVC isKindOfClass:[UINavigationController class]])
    {
        UINavigationController * chooseNavi = (UINavigationController *)rootVC;
        
        return chooseNavi.visibleViewController;
    }
    
    else
    {
        return rootVC;
    }
    
    return rootVC;
    
}

+(UIViewController *)getCurrentPresentViewController:(UIViewController *)vc
{
    UIViewController * vaildVC;
    
    //开始判断。
    //1.先查看是否存在presentedVC.
    if (vc.presentedViewController) {
        
        vaildVC = vc.presentedViewController;
    }
    else
    {
        vaildVC = vc;
    }
    
    return vaildVC;
}


@end
