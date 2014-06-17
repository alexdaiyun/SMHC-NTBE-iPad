//
//  FlatFrameButton.h
//  FlatFrameButtonExample
//
//  Created by dai yun on 14-6-13.
//  Copyright (c) 2014年 alexday. All rights reserved.
//

#import <UIKit/UIKit.h>

// 提供两种样式的按钮

// 样式
// FlatFrameButtonStyleSingleLine：单边框，无背影
// FlatFrameButtonStyleDefault: 单边框，有背景
typedef enum {
    FlatFrameButtonStyleDefault = 0,
    FlatFrameButtonStyleSingleLine,
} FlatFrameButtonStyle;

@interface FlatFrameButton : UIButton

@property (nonatomic) FlatFrameButtonStyle flatFrameButtonStyle;

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *backgroundSelectedColor;
//- (void)setBorderColor:(UIColor *)borderColor;
@end
