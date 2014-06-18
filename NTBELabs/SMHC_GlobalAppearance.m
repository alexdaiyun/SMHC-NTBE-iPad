//
//  SMHC_GlobalAppearance.m
//  NTBELabs
//
//  Created by dai yun on 14-6-17.
//  Copyright (c) 2014年 alexday. All rights reserved.
//

#import "SMHC_GlobalAppearance.h"

@implementation SMHC_GlobalAppearance

+ (void)customizeAppearance
{
    
    [self navigationBarAppearance];
    [self tabBarAppearance];
    [self buttonAppearance];
    
}

+ (void)navigationBarAppearance
{
    
    if (AT_LEAST_IOS(7))
    {
        // for iOS 7 or later
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setBarTintColor:kAppPrimaryColor];
//        [[UINavigationBar appearance] setTitleTextAttributes:@{
//                                                               UITextAttributeTextColor:[UIColor whiteColor],
//                                                               UITextAttributeTextShadowColor:[UIColor clearColor]}];
    }
    else
    {
        // for iOS 6.1 or earlier
        [[UINavigationBar appearance] setTintColor:kAppPrimaryColor];
    }
    
}

+ (void)tabBarAppearance
{
    [[UITabBar appearance] setSelectedImageTintColor:kAppPrimaryColor];
    if (AT_LEAST_IOS(7))
    {
        // for iOS 7 or later
    }
    else
    {
        // for iOS 6.1 or earlier
        //[[UITabBar appearance] setTintColor: [UIColor redColor]];
    }
}

+ (void)buttonAppearance
{
    [[UIButton appearance] setTintColor:kAppPrimaryColor];
    
    //	[[UIButton appearanceWhenContainedIn:[ABMBlueNavigationBarController class], nil] setBackgroundImage:blueNavigationBarPortrait
    //		  forBarMetrics:UIBarMetricsDefault];
    
    
    if (AT_LEAST_IOS(7))
    {
        // for iOS 7 or later
        
    }
    else
    {
        // for iOS 6.1 or earlier
    }
}

+ (void)tableViewAppearance
{
    [[UITableView appearance] setBackgroundColor:[UIColor whiteColor]];
    if (AT_LEAST_IOS(7))
    {
        // for iOS 7 or later
        
    }
    else
    {
        // for iOS 6.1 or earlier
    }
}


@end
