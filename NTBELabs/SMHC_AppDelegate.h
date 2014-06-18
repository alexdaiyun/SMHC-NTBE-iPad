//
//  SMHC_AppDelegate.h
//  NTBELabs
//
//  Created by dai yun on 14-6-17.
//  Copyright (c) 2014年 alexday. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SMHC_GlobalAppearance.h"
#import "SMHC_AppController.h"
#import "SMHC_AppFactory.h"

#define ApplicationDelegate ((TM_AppDelegate *)[UIApplication sharedApplication].delegate)

@interface SMHC_AppDelegate : UIResponder <UIApplicationDelegate>
{
    SMHC_AppController *appController;
}

@property (strong, nonatomic) UIWindow *window;

@end
