//
//  SMHC_AppDelegate.m
//  NTBELabs
//
//  Created by dai yun on 14-6-17.
//  Copyright (c) 2014年 alexday. All rights reserved.
//

#import "SMHC_AppDelegate.h"

@implementation SMHC_AppDelegate

#pragma mark - AppController

- (SMHC_AppController *)appController {
	if (!appController) {
		appController = [[SMHC_AppController alloc] initWithAppFactory:[SMHC_AppFactory new]];
	}
	return appController;
}

#pragma mark - Start-up
- (void)Startup
{
    //启动时处理数据库文件
    [self CheckAndCreateDatabae];
   
}
- (void)CheckAndCreateDatabae
{
    //Create a FileManager object, we will use this to check the status
    // of the database and to copy it over if required
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Check if the SQL database has already been saved to the users phone, if not then copy it over
    BOOL success;
    
    NSError *error;
    
    
    //Documents目录中的Database文件及路径
    
    NSString *appDBPath = AppDBFullPath; //[AppUtil getAppDBPath];
    
    
    success = [fileManager fileExistsAtPath:appDBPath];
    
    if (success) return;
    
    //若文件不存在，则从App pack中复制
    // App pack => Documents
    NSString *sourceDBPath = [PATH_OF_APP_RESOURCE stringByAppendingPathComponent:AppDBName];
    
    success = [fileManager copyItemAtPath:sourceDBPath toPath:appDBPath error:&error];
    
    if (!success)
    {
        SLLog(@"Copy Database file to Documents error ");
    }
    
    /*
     
     if ([fileManager fileExistsAtPath:dbFilePath] == NO)
     {
     NSLog(@"not Exists");
     }
     else
     {
     NSLog(@"yes Exists");
     }
     
     */
}



#pragma mark - View lifecyle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 加载全局自定义样式
    [SMHC_GlobalAppearance customizeAppearance];
    
    // 准备加载视图
    [self.appController setAppWindow:self.window];
    [self.appController launchInWindow:self.window];
    
    //[self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // Called when the application Receive Memory Warning.
}

@end
