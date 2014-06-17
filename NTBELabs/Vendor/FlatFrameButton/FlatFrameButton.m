//
//  FlatFrameButton.m
//  FlatFrameButtonExample
//
//  Created by dai yun on 14-6-13.
//  Copyright (c) 2014年 alexday. All rights reserved.
//

#import "FlatFrameButton.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat const BtnDefaultFontSize = 15.0;
static CGFloat const BtnCornerRadius = 4.0;
static CGFloat const BtnBorderWidth = 1.0;
static CGFloat const BtnAnimationDuration = 0.25;
static UIEdgeInsets const BtnContentDegeInsets = {5, 10, 5, 10};


@interface FlatFrameButton ()
{
    UIColor *buttonBorderColor;
    UIColor *buttonBackgroundColor;
    UIColor *buttonBackgroundHighlightColor;
    UIColor *buttonBackgroundSelectedColor;
}

@end

/*
$red:   #E0645C;
$dark:  #444444;
$light: #999999;
$blue:  #2DB6CF;
$green: #46b98a;
$white: #FFFFFF;
*/



@implementation FlatFrameButton

@synthesize flatFrameButtonStyle;
@synthesize borderColor;
@synthesize backgroundSelectedColor;
 

- (id)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonInit];
        [self setupDefautlConfig];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{

    
    borderColor = [UIColor blueColor];
    backgroundSelectedColor = [UIColor whiteColor];
    
    self.layer.cornerRadius = BtnCornerRadius;
    self.layer.borderWidth = BtnBorderWidth;
    self.layer.borderColor = borderColor.CGColor;
    [self setContentEdgeInsets:BtnContentDegeInsets];

    self.flatFrameButtonStyle = FlatFrameButtonStyleDefault;
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected|UIControlStateHighlighted];
    
    
    
    [self refreshBorderColor];

}

- (void)setupDefautlConfig
{
    [self.titleLabel setFont:[UIFont systemFontOfSize:BtnDefaultFontSize]];
}



- (void)setHighlighted:(BOOL)highlighted
{
    // Only change if necessary.
//    if ( highlighted == super.highlighted ) {
//        return;
//    }
    
    [super setHighlighted:highlighted];
    
    [UIView animateWithDuration:BtnAnimationDuration animations:^{
        if (highlighted)
        {
            // 当用户触摸按钮时高亮状态
          
            if (self.selected) {
                // 按钮selected为YES时
                
//                CGFloat r, g, b;
//                
//                [self.tintColor getRed:&r green:&g blue:&b alpha:nil];
//                self.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:0.5];
//                self.layer.borderColor = [UIColor clearColor].CGColor;
                NSLog(@"highlighted - selected");
                
                
            } else {
                // 按钮selected为NO时
                NSLog(@"highlighted - not selected");
                // 高亮时背景色
                
                self.backgroundColor = borderColor;
            }
            
            
        }
        else
        {
            // 当用户触摸按钮后退出高亮状态
            self.layer.borderColor = borderColor.CGColor;
            // self.tintColor.CGColor;
            
            if (self.selected) {
                // 按钮selected为YES时
                //NSLog(@"not highlighted - selected");

            } else {
                // 按钮selected为NO时
                //NSLog(@"not highlighted - not selected");
                // 高亮结束时，还原背景色
                
                switch (flatFrameButtonStyle) {
                    case FlatFrameButtonStyleDefault:
                        //
                        //self.backgroundColor = buttonBackgroundColor;
                        break;
                    case FlatFrameButtonStyleSingleLine:
                        self.backgroundColor = [UIColor clearColor];
                        break;
                    default:
                        break;
                }

            }
            
        }
    }];
    
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected)
    {
        NSLog(@"setSelected - selected");
        self.backgroundColor = borderColor;
        //[UIColor colorWithCGColor:self.layer.borderColor] ; //self.tintColor;
        
    }
    else
    {
        NSLog(@"setSelected - not selected");
        
    }
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self refreshBorderColor];
}

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    [self setTitleColor:tintColor forState:UIControlStateNormal];
    
    
    [self refreshBorderColor];
    
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    
//    if (backgroundColor != [UIColor clearColor])
//    {
//        // 如果设置了背景色，则边框色与背景色一致
//       // self.layer.borderColor = backgroundColor.CGColor;
//    }
//    else
//    {
//        NSLog(@"backgroundcolor clearColor");
//    }
    

    
}

- (void)setBorderColor:(UIColor *)theBorderColor
{
    borderColor = theBorderColor;
    //buttonBackgroundColor = theBorderColor;
    self.layer.borderColor = theBorderColor.CGColor;
}

- (void)setBackgroundSelectedColor:(UIColor *)theBackgroundSelectedColor
{
    self.backgroundSelectedColor = theBackgroundSelectedColor;
}

- (void)setFlatFrameButtonStyle:(FlatFrameButtonStyle)theFlatFrameButtonStyle
{
    flatFrameButtonStyle = theFlatFrameButtonStyle;
    switch (theFlatFrameButtonStyle)
    {
        case FlatFrameButtonStyleDefault:
            self.backgroundColor = borderColor;
            break;
        case FlatFrameButtonStyleSingleLine:
            self.backgroundColor =[UIColor clearColor];
            break;
        default:
            break;
    }
}

- (void)tintColorDidChange
{
    //self.layer.borderColor = self.tintColor.CGColor;
    [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    
    NSLog(@"tintColorDidChange");
    
    if (self.selected)
    {
        NSLog(@"tintColorDidChange - selected");
        //self.backgroundColor = self.tintColor;
    }
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize org = [super sizeThatFits:self.bounds.size];
    return CGSizeMake(org.width + 20, org.height -2);
}

- (void)refreshBorderColor
{
    //self.layer.borderColor = [self isEnabled] ? self.tintColor.CGColor : [UIColor grayColor].CGColor;
    if (!self.isEnabled)
    {
        self.layer.borderColor = [UIColor grayColor].CGColor;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
