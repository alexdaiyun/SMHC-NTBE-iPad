//
//  FlatFrameButton+Bootstrap.m
//  FlatFrameButtonExample
//
//  Created by dai yun on 14-6-16.
//  Copyright (c) 2014年 alexday. All rights reserved.
//

#import "FlatFrameButton+Bootstrap.h"
#import <QuartzCore/QuartzCore.h>

@implementation FlatFrameButton (Bootstrap)

- (void)bootstrapStyle
{
    [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
//    [self setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
//    [self setTitleColor:[UIColor blueColor] forState:UIControlStateSelected|UIControlStateHighlighted];
    
    [self setBorderColor:[UIColor whiteColor]];
    
    
    
}


- (void)defaultStyle
{
    [self bootstrapStyle];
    
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    self.borderColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
 

    
}

- (void)logoutStyle
{
    [self bootstrapStyle];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.borderColor = [UIColor redColor];
    self.BackgroundColor = [UIColor redColor];

    self.flatFrameButtonStyle = FlatFrameButtonStyleDefault;
    
    
}

// 无填充
- (void)noFillStyle
{
    [self bootstrapStyle];
}



@end
