//
//  SMHC_AppFactory.h
//  NTBELabs
//
//  Created by dai yun on 14-6-18.
//  Copyright (c) 2014年 alexday. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMHC_AppController;

@interface SMHC_AppFactory : NSObject

@property (weak) SMHC_AppController *appController;

@property (readonly) UINavigationController *mainNavigationController;

- (void)clear_MainNavigationController;

@end
