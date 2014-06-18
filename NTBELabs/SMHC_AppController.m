//
//  SMHC_AppController.m
//  NTBELabs
//
//  Created by dai yun on 14-6-18.
//  Copyright (c) 2014年 alexday. All rights reserved.
//

#import "SMHC_AppController.h"

@implementation SMHC_AppController

- (id)initWithAppFactory:(SMHC_AppFactory *)aFactory
{
    if (self = [super init])
    {
        _factory = aFactory;
        [_factory setAppController:self];
    }
    return self;
}

- (void)launchInWindow:(UIWindow *)aWindow
{
   
    [aWindow  setRootViewController:self.factory.mainNavigationController];
    
    [aWindow makeKeyAndVisible];
    
}

- (void)showMainStoryboard
{
    [self.factory clear_MainNavigationController];
    
    [self.appWindow setRootViewController:self.factory.mainNavigationController];
    [self.appWindow makeKeyAndVisible];
}

@end
