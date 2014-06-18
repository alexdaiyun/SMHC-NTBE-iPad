//
//  SMHC_AppController.h
//  NTBELabs
//
//  Created by dai yun on 14-6-18.
//  Copyright (c) 2014年 alexday. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SMHC_AppFactory.h"
#import "SMHC_AppDelegate.h"

@class SMHC_AppFactory;

@interface SMHC_AppController : NSObject

@property (readonly) SMHC_AppFactory *factory;

@property (strong, nonatomic) UIWindow *appWindow;

- (id)initWithAppFactory:(SMHC_AppFactory *)aFactory;

- (void)launchInWindow:(UIWindow *)aWindow;

- (void)showMainStoryboard;

@end
