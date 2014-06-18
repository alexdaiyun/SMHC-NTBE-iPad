//
//  AppUtil.h
//  TaxMarksMTM
//
//  Created by dai yun on 14-5-4.
//  Copyright (c) 2014年 alexday. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <mach/mach.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@interface AppUtil : NSObject
{
     NSUInteger *activityCount;
 
}



+ (AppUtil *)sharedAppUtil;


#pragma mark - Memory Info
BOOL memoryInfo(vm_statistics_data_t *vmStats);

+ (NSString *)get_MemoryInfo;

#pragma mark - UILabel
+ (void)alignLabelWithTop:(UILabel *)label;

#pragma mark - UITextView
+ (float)heightForTextView: (UITextView *)textView WithText: (NSString *) strText;

#pragma mark - Validate

+ (BOOL)isValidateMobileNumber:(NSString *)mobileNum;

+ (BOOL)isValidateEmail:(NSString *)email;

#pragma mark - network activity indicator management
- (void) refreshNetworkIndicator;
- (void) startNetworkAction;
- (void) endNetworkAction;
+ (BOOL) isConnected;

#pragma mark - Error and alert Functions

- (void) receivedException:(NSException *)e;
- (void) receivedAPIError:(NSError *)error;
- (void) internalError:(NSError *)error;

#pragma mark - Misc utility functions
+ (NSString *) truncateURL:(NSString *)url;
+ (NSString *) trimWhiteSpaceFromString:(NSString *)source;
+ (BOOL) isEmpty:(id) thing;
+ (BOOL) stringIsEmpty:(NSString *) thing;
+ (NSArray *) randomSubsetFromArray:(NSArray *)original ofSize:(int)size;
+ (NSString *) SQLDatetimeFromDate:(NSDate *)date isDateTime:(BOOL)isDateTime;
+ (NSDate *) dateFromSQLDatetime:(NSString *)datetime;
+ (NSString *)stringWithDate:(NSDate *)date;
+ (NSArray *) filterRecords:(NSArray *)records dateField:(NSString *)dateField withDate:(NSDate *)date createdAfter:(BOOL)createdAfter;
+ (NSArray *)sortArray:(NSArray *)toSort;
+ (NSString *)relativeTime:(NSDate *)sinceDate;

void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight);

+ (NSString *) stripHTMLTags:(NSString *)str;
+ (NSString *) stringByDecodingEntities:(NSString *)str;

+ (NSString *)getIPAddress;

+ (NSString *)getDate;

@end
