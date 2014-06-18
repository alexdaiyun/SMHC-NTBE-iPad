//
//  SMHC_AppFactory.m
//  NTBELabs
//
//  Created by dai yun on 14-6-18.
//  Copyright (c) 2014年 alexday. All rights reserved.
//

#import "SMHC_AppFactory.h"

@implementation SMHC_AppFactory
{
    UINavigationController *mainNavigationController;
}

// MainStoryboard 初始化
- (UINavigationController *)mainNavigationController {
    if (!mainNavigationController)
    {
        // 获得storyboard实例
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        mainNavigationController = [storyboard instantiateInitialViewController];
        
        // storyboard 中第一个VC
        
    }
    return mainNavigationController;
}


- (void)clear_MainNavigationController
{
    mainNavigationController = nil;
}


@end
