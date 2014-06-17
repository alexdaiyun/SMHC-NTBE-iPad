//  MacroUtils.h
//  定义标识符、常量、宏等
//

#ifndef MacroDefines_h
#define MacroDefines_h

#warning
// NEED_OUTPUT_LOG   0 not output / 1 output
#define NEED_OUTPUT_LOG                     1


// 定义常量
#pragma mark - define constants

#define EMPTY_STRING                        @""

#define DownArrowCharacter @"▼"
#define UpArrowCharacter @"▲"


// 定义与AppStroe相关的常量
#pragma mark - AppStroe

// AppStroe中的链接(http协议)
#define APP_STORE_LINK_http                 @""
//https://itunes.apple.com/cn/app/dou-ban-xiang-ce-jing-xuan-ji/id588070942?ls=1&mt=8"

// AppStroe中的链接(iTunes协议)
#define APP_STORE_LINK_iTunes               @""
//itms-apps://itunes.apple.com/cn/app/id588070942?mt=8"

// AppStroe中的评论链接(iTunes协议)
#define APP_COMMENT_LINK_iTunes             @""
//itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=588070942"


#pragma mark - define variable



#pragma mark - define Method

// 获得iOS版本号
#define IOS_VERSION                 [[UIDevice currentDevice] systemVersion]

// 当前最少支持的iOS版本号
#define AT_LEAST_IOS(xxx)           ([[IOS_VERSION substringToIndex:1] intValue] >= xxx )

// for iOS 6.1 or earlier
#define Under_IOS_6_1               (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)

// NotificationCenter
#define NOTIFICATION_CENTER         [NSNotificationCenter defaultCenter]

// UserDefaults
#define USER_DEFAULT                [NSUserDefaults standardUserDefaults]


#define NSNumberFromInt(i)          [NSNumber numberWithInt:i]



#pragma mark - define Method - Screen

// 设备分辨率的比例因子
#define DeviceScale                 [[UIScreen mainScreen] scale]
// 设备纵向的屏幕宽度
#define DevicePortraitWindowWidth   CGRectGetWidth( [[UIScreen mainScreen] bounds] )
// 设备纵向的屏幕高度
#define DevicePortraitWindowHeight  CGRectGetHeight( [[UIScreen mainScreen] bounds] )

// 主屏幕的屏幕尺寸宽度
#define APP_SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
// 主屏幕的屏幕尺寸高度
#define APP_SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height
// 主屏幕的内部高度
#define APP_SCREEN_CONTENT_HEIGHT   ([UIScreen mainScreen].bounds.size.height-20.0)
// 当前设备是否为4寸屏
#define IS_4_INCH                   (APP_SCREEN_HEIGHT > 480.0)

//iOS 5 Declaring the Supported Interface Orientations
#define UIDeviceOrientationIsPortrait(orientation)  ((orientation) == UIDeviceOrientationPortrait || (orientation) == UIDeviceOrientationPortraitUpsideDown)
#define UIDeviceOrientationIsLandscape(orientation) ((orientation) == UIDeviceOrientationLandscapeLeft || (orientation) == UIDeviceOrientationLandscapeRight)

//iOS 6 Declaring the Supported Interface Orientations
#define UIInterfaceOrientationMaskPortrait          (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown)
#define UIInterfaceOrientationMaskLandscape         (UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight)

// assuming CGRect b is smaller than CGRect a, returns a single origin point for rect b such that it is centered,
// by size, within rect a
#define CGPointCenteredOriginPointForRects(a, b)    CGPointMake( \
CGRectGetMinX(a) + floorf( ( ABS( CGRectGetWidth( a ) - CGRectGetWidth( b ) ) ) / 2.0f ), \
CGRectGetMinY(a) + floorf( ( ABS( CGRectGetHeight( a ) - CGRectGetHeight( b ) ) ) / 2.0f ) )


#pragma mark - define Method - Directory

// App主目录
#define PATH_OF_APP_HOME        NSHomeDirectory()
// App的资源文件目录
#define PATH_OF_APP_RESOURCE    [[NSBundle mainBundle] resourcePath]
// App的Temporary目录
#define PATH_OF_TEMP            NSTemporaryDirectory()
// App的Document目录
#define PATH_OF_DOCUMENT        [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// App的Support目录
#define PATH_OF_APP_SUPPORT     [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// App的Caches目录
#define PATH_OF_CACHES          [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]


#pragma mark - define Method - Color

// 从RGB转换成UIColor
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 创建一个RGB值的UIColor
#define RGBCOLOR(r,g,b)             [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
// 创建一个RGBA值的UIColor
#define RGBACOLOR(r,g,b,a)          [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]




#pragma mark - Debug Log

#if NEED_OUTPUT_LOG

    #define SLog(xx, ...)   NSLog(xx, ##__VA_ARGS__)
    #define SLLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

    #define SLLogRect(rect) \
    SLLog(@"%s x=%f, y=%f, w=%f, h=%f", #rect, rect.origin.x, rect.origin.y, \
    rect.size.width, rect.size.height)

    #define SLLogPoint(pt) \
    SLLog(@"%s x=%f, y=%f", #pt, pt.x, pt.y)

    #define SLLogSize(size) \
    SLLog(@"%s w=%f, h=%f", #size, size.width, size.height)

    #define SLLogColor(_COLOR) \
    SLLog(@"%s h=%f, s=%f, v=%f", #_COLOR, _COLOR.hue, _COLOR.saturation, _COLOR.value)

    #define SLLogSuperViews(_VIEW) \
    { for (UIView* view = _VIEW; view; view = view.superview) { SLLog(@"%@", view); } }

    #define SLLogSubViews(_VIEW) \
    { for (UIView* view in [_VIEW subviews]) { SLLog(@"%@", view); } }

#else

    #define SLog(xx, ...)  ((void)0)
    #define SLLog(xx, ...)  ((void)0)

#endif /* if NEED_OUTPUT_LOG */

/*
 控制NSLog的输出
 1 显示输出
 0 不显示输出
 */


#if NEED_OUTPUT_LOG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif



#endif