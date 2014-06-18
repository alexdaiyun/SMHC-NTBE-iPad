//
//  AppUtil.m
//  TaxMarksMTM
//
//  Created by dai yun on 14-5-4.
//  Copyright (c) 2014年 alexday. All rights reserved.
//

#import "AppUtil.h"

@implementation AppUtil


+ (AppUtil *)sharedAppUtil
{
    static AppUtil *appUtil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appUtil = [[self alloc] init];
    });
    return appUtil;
}



#pragma mark - Memory Info
BOOL memoryInfo(vm_statistics_data_t *vmStats){
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)vmStats, &infoCount);
    
    return kernReturn == KERN_SUCCESS;
}


+ (NSString *)get_MemoryInfo {
    vm_statistics_data_t vmStats;
    NSString *_memoryInfo = @"";
    
    if (memoryInfo(&vmStats)) {
        /*
         NSLog(@"free: %u\nactive: %u\ninactive: %u\nwire: %u\nzero fill: %u\nreactivations: %u\npageins: %u\npageouts: %u\nfaults: %u\ncow_faults: %u\nlookups: %u\nhits: %u",
         vmStats.free_count * vm_page_size,
         vmStats.active_count * vm_page_size,
         vmStats.inactive_count * vm_page_size,
         vmStats.wire_count * vm_page_size,
         vmStats.zero_fill_count * vm_page_size,
         vmStats.reactivations * vm_page_size,
         vmStats.pageins * vm_page_size,
         vmStats.pageouts * vm_page_size,
         vmStats.faults,
         vmStats.cow_faults,
         vmStats.lookups,
         vmStats.hits
         );
         */
        
        _memoryInfo = [NSString stringWithFormat:@"total:%uMB free:%uMB active:%uMB wire:%uMB inactive:%uMB",(NSRealMemoryAvailable()/(1024*1024)),(vmStats.free_count * vm_page_size /(1024*1024)),
                       (vmStats.active_count * vm_page_size/(1024*1024)),(vmStats.wire_count * vm_page_size/(1024*1024)), (vmStats.inactive_count * vm_page_size/(1024*1024))];
    }
    //MemoryText.title  = _memoryInfo;
    
    //NSLog(@"%@", _memoryInfo);
    
    return _memoryInfo;
}

#pragma mark - UI Label
// adjust the height of a multi-line label to make it align vertical with top
+ (void)alignLabelWithTop:(UILabel *)label {
	CGSize maxSize = CGSizeMake(label.frame.size.width, MAXFLOAT);
	label.adjustsFontSizeToFitWidth = NO;
    
	// get actual height
	CGSize actualSize = [label.text sizeWithFont:label.font constrainedToSize:maxSize lineBreakMode:label.lineBreakMode];
	CGRect rect = label.frame;
	rect.size.height = actualSize.height;
	label.frame = rect;
    
}

#pragma mark - UITextView

// 计算UITextView的高度
// UITextView的上下左右分别有8px的padding
+ (float)heightForTextView: (UITextView *)textView WithText: (NSString *) strText
{
    float heightOfTextView = 0;
    
    NSLog(@"textView frame.w: %f", textView.frame.size.width);
    NSLog(@"textView frame.h: %f", textView.frame.size.height);
    

    NSLog(@"textView contentSize.w: %f", textView.contentSize.width);
    NSLog(@"textView contentSize.h: %f", textView.contentSize.height);
    
    if (AT_LEAST_IOS(7))
    {
       // CGRect frame_textView=[[textView layoutManager]usedRectForTextContainer:[textView textContainer]];
       // fHeight = frame_textView.size.height;
        heightOfTextView = textView.contentSize.height;
 
    }
    else
    {
        // iOS 6 有效
        // http://www.howlin-interactive.com/2013/01/creating-a-self-sizing-uitextview-within-a-uitableviewcell-in-ios-6/
        
        float horizontalPadding = 16; // 8.0px x 2
        float verticalPadding = 16; // 8.0px x 2
        
        float widthOfTextView = textView.contentSize.width - horizontalPadding;
        
        heightOfTextView = [strText sizeWithFont:textView.font constrainedToSize:CGSizeMake(widthOfTextView, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height + verticalPadding + 21;
      
        //heightOfTextView = textView.contentSize.height;
        
    }
    
    // 如果计算出来的高度小于原来的高度则不改变
    if (heightOfTextView < textView.frame.size.height)
    {
        return textView.frame.size.height;
    }
    
    return heightOfTextView;
}

#pragma mark - Validate

// 正则判断手机号码地址格式
+ (BOOL)isValidateMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     * 14,17
     */
    NSString * MOBILE = @"^1(3[0-9]|4[0-9]|5[0-35-9]|7[0-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

// 正则表达式验证邮箱地址格式
+ (BOOL)isValidateEmail:(NSString *)email

{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

#pragma mark - network activity indicator management

- (void) refreshNetworkIndicator {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = activityCount >0;
}

- (void) startNetworkAction {
    // Start the network activity spinner
    if ( !activityCount )
        activityCount = 0;
    
    activityCount ++;
    
    [self refreshNetworkIndicator];
    
}

- (void) endNetworkAction {
    if ( activityCount >0 )
        activityCount --;
    else
        activityCount = 0;
    
    [self refreshNetworkIndicator];
}


+ (BOOL) isConnected {
    NSURL *url = [NSURL URLWithString:@"http://ww.google.com"];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSHTTPURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    return (response != nil);
    
}

#pragma mark - Error and alert Functions

- (void) receivedException:(NSException *)e {
    NSLog(@"*** Exception *** %@", e);
}

- (void) receivedAPIError:(NSError *)error {
    NSLog(@"*** API ERROR *** %@", error);
}

- (void) internalError:(NSError *)error {
    NSLog(@"*** Unresolved error %@, %@", error, [error userInfo]);
}


#pragma mark - Misc utility functions
+ (NSString *) truncateURL:(NSString *)url {
    NSMutableString *ret = [url mutableCopy];
    
    for( NSString *prefix in [NSArray arrayWithObjects:@"http://", @"https://", @"www.", nil] )
        if( [ret hasPrefix:prefix] )
            [ret deleteCharactersInRange:NSMakeRange( 0, [prefix length] )];
    
    if( [ret hasSuffix:@"/"] )
        [ret deleteCharactersInRange:NSMakeRange( [ret length] - 1, 1 )];
    
    return  ret ;
}


+ (NSString *) trimWhiteSpaceFromString:(NSString *)source {
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    
    NSArray *parts = [source componentsSeparatedByCharactersInSet:whitespaces];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    
    source = [filteredArray componentsJoinedByString:@" "];
    
    while( [source rangeOfString:@"\n \n"].location != NSNotFound )
        source = [source stringByReplacingOccurrencesOfString:@"\n \n" withString:@"\n"];
    
    return source;
}

+ (BOOL) isEmpty:(id) thing {
    return thing == nil
    || [thing isKindOfClass:[NSNull class]]
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

+ (BOOL) stringIsEmpty:(NSString *)thing
{
    if(thing == nil)
    {
        return YES;
    }
    if([thing isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    return [[thing stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""];
}

+ (NSArray *) randomSubsetFromArray:(NSArray *)original ofSize:(int)size {
    NSMutableSet *names = [NSMutableSet set];
    
    if( !original || [original count] == 0 )
        return [NSArray array];
    
    if( size <= 0 || size >= [original count] )
        return original;
    
    do {
        [names addObject:[original objectAtIndex:( arc4random() % [original count] )]];
    } while( [names count] < size );
    
    return [names allObjects];
}

+ (NSString *) SQLDatetimeFromDate:(NSDate *)date isDateTime:(BOOL)isDateTime {
    if( !date )
        date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    
    NSDateFormatter *dformatter = [[NSDateFormatter alloc] init];
    [dformatter setLocale:[NSLocale currentLocale]];
    
    if( isDateTime ) {
        [dformatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.000Z'"];
        NSTimeZone *tz = [NSTimeZone defaultTimeZone];
        NSInteger seconds = -[tz secondsFromGMTForDate:date];
        date = [NSDate dateWithTimeInterval:seconds sinceDate:date];
    } else
        [dformatter setDateFormat:@"yyyy'-'MM'-'dd"];
    
    NSString *format = [dformatter stringFromDate:date];
    //[dformatter release];
    
    return format;
}

+ (NSDate *) dateFromSQLDatetime:(NSString *)datetime {
    // datetime 2011-01-24T17:34:14.000Z
    // date 2011-01-24
    NSDate *date;
    BOOL isDateTime = NO;
    
    if( [self isEmpty:datetime] )
        return [NSDate dateWithTimeIntervalSinceNow:0];
    
    datetime = [datetime stringByReplacingOccurrencesOfString:@".000Z" withString:@""];
    datetime = [datetime stringByReplacingOccurrencesOfString:@".000+0000" withString:@""]; // REST
    datetime = [datetime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    datetime = [self trimWhiteSpaceFromString:datetime];
    
    NSDateFormatter *dformatter = [[NSDateFormatter alloc] init];
    [dformatter setLocale:[NSLocale currentLocale]];
    
    if( [datetime rangeOfString:@" "].location == NSNotFound )
        [dformatter setDateFormat:@"yyyy-MM-dd"];
    else {
        [dformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        isDateTime = YES;
    }
    
    date = [dformatter dateFromString:datetime];
    //[dformatter release];
    
    // only do time zone adjustments for datetimes
    if( isDateTime ) {
        NSTimeZone *tz = [NSTimeZone defaultTimeZone];
        NSInteger seconds = [tz secondsFromGMTForDate:date];
        return [NSDate dateWithTimeInterval:seconds sinceDate:date];
    }
    
    return date;
}


+ (NSString *)stringWithDate:(NSDate *)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* datestr = [formatter stringFromDate:date];
    return datestr;
}


+ (NSArray *) filterRecords:(NSArray *)records dateField:(NSString *)dateField withDate:(NSDate *)date createdAfter:(BOOL)createdAfter {
    if( !records || !dateField )
        return nil;
    
    if( !date || [records count] == 0 )
        return records;
    
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:[records count]];
    
    for( NSDictionary *record in records ) {
        NSComparisonResult result = [date compare:[self dateFromSQLDatetime:[record objectForKey:dateField]]];
        
        if( createdAfter && result == NSOrderedAscending )
            [ret addObject:record];
        else if( !createdAfter && result == NSOrderedDescending )
            [ret addObject:record];
    }
    
    return ret;
}

// Sort an array alphabetically
+ (NSArray *)sortArray:(NSArray *)toSort {
    if( !toSort || [toSort count] == 0 )
        return [NSArray array];
    
    if( [[toSort objectAtIndex:0] isKindOfClass:[NSString class]] )
        return [toSort sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    return [toSort sortedArrayUsingSelector:@selector(compare:)];
}

// Returns a relative amount of time since a date
+ (NSString *)relativeTime:(NSDate *)sinceDate {
    double d = fabs( [sinceDate timeIntervalSinceNow] );
    
    if( d < 2 )
        return NSLocalizedString(@"just now", @"just now relative time");
    else if (d < 60) {
        int diff = round(d);
        return [NSString stringWithFormat:@"%d%@",
                diff,
                NSLocalizedString(@"s ago", @"seconds ago relative time")];
    } else if (d < 3600) {
        int diff = round(d / 60);
        return [NSString stringWithFormat:@"%d%@",
                diff,
                NSLocalizedString(@"m ago", @"minutes ago relative time")];
    } else if (d < 86400) {
        int diff = round(d / 60 / 60);
        return [NSString stringWithFormat:@"%d%@",
                diff,
                NSLocalizedString(@"h ago", @"hours ago relative time")];
    } else if (d < 2629743) {
        int diff = round(d / 60 / 60 / 24);
        return [NSString stringWithFormat:@"%d%@",
                diff,
                NSLocalizedString(@"d ago", @"days ago relative time")];
    } else {
        int diff = round(d / 60 / 60 / 24 / 30);
        return [NSString stringWithFormat:@"%d%@",
                diff,
                NSLocalizedString(@"mo ago", @"months ago relative time")];
    }
}

void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight) {
    float fw, fh;
	if (ovalWidth == 0 || ovalHeight == 0) {
		CGContextAddRect(context, rect);
		return;
	}
	CGContextSaveGState(context);
	CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
	CGContextScaleCTM (context, ovalWidth, ovalHeight);
	fw = CGRectGetWidth (rect) / ovalWidth;
	fh = CGRectGetHeight (rect) / ovalHeight;
	CGContextMoveToPoint(context, fw, fh/2);
	CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
	CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
	CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
	CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
	CGContextClosePath(context);
	CGContextRestoreGState(context);
}

+ (NSString *) stripHTMLTags:(NSString *)str {
    NSMutableString *html = [NSMutableString stringWithCapacity:[str length]];
    
    NSScanner *scanner = [NSScanner scannerWithString:str];
    NSString *tempText = nil;
    
    while (![scanner isAtEnd]) {
        [scanner scanUpToString:@"<" intoString:&tempText];
        
        if (tempText != nil)
            [html appendString:[NSString stringWithFormat:@" %@", tempText]];
        
        [scanner scanUpToString:@">" intoString:NULL];
        
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation] + 1];
        
        tempText = nil;
    }
    
    return [self trimWhiteSpaceFromString:html];
}


+ (NSString *)stringByDecodingEntities:(NSString *)str {
    NSUInteger myLength = [str length];
    NSUInteger ampIndex = [str rangeOfString:@"&" options:NSLiteralSearch].location;
    
    // Short-circuit if there are no ampersands.
    if (ampIndex == NSNotFound) {
        return str;
    }
    // Make result string with some extra capacity.
    NSMutableString *result = [NSMutableString stringWithCapacity:(myLength * 1.25)];
    
    // First iteration doesn't need to scan to & since we did that already, but for code simplicity's sake we'll do it again with the scanner.
    NSScanner *scanner = [NSScanner scannerWithString:str];
    
    [scanner setCharactersToBeSkipped:nil];
    
    NSCharacterSet *boundaryCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@" \t\n\r;"];
    
    do {
        // Scan up to the next entity or the end of the string.
        NSString *nonEntityString;
        if ([scanner scanUpToString:@"&" intoString:&nonEntityString]) {
            [result appendString:nonEntityString];
        }
        if ([scanner isAtEnd]) {
            goto finish;
        }
        // Scan either a HTML or numeric character entity reference.
        if ([scanner scanString:@"&amp;" intoString:NULL])
            [result appendString:@"&"];
        else if([scanner scanString:@"&nbsp;" intoString:NULL])
            [result appendString:@" "];
        else if ([scanner scanString:@"&apos;" intoString:NULL])
            [result appendString:@"'"];
        else if ([scanner scanString:@"&quot;" intoString:NULL])
            [result appendString:@"\""];
        else if ([scanner scanString:@"&lt;" intoString:NULL])
            [result appendString:@"<"];
        else if ([scanner scanString:@"&gt;" intoString:NULL])
            [result appendString:@">"];
        else if ([scanner scanString:@"&#" intoString:NULL]) {
            BOOL gotNumber;
            unsigned charCode;
            NSString *xForHex = @"";
            
            // Is it hex or decimal?
            if ([scanner scanString:@"x" intoString:&xForHex]) {
                gotNumber = [scanner scanHexInt:&charCode];
            }
            else {
                gotNumber = [scanner scanInt:(int*)&charCode];
            }
            
            if (gotNumber) {
                [result appendFormat:@"%C", (unichar)charCode];
                
                [scanner scanString:@";" intoString:NULL];
            }
            else {
                NSString *unknownEntity = @"";
                
                [scanner scanUpToCharactersFromSet:boundaryCharacterSet intoString:&unknownEntity];
                
                
                [result appendFormat:@"&#%@%@", xForHex, unknownEntity];
                
                //[scanner scanUpToString:@";" intoString:&unknownEntity];
                //[result appendFormat:@"&#%@%@;", xForHex, unknownEntity];
                NSLog(@"Expected numeric character entity but got &#%@%@;", xForHex, unknownEntity);
                
            }
            
        }
        else {
            NSString *amp;
            
            [scanner scanString:@"&" intoString:&amp];      //an isolated & symbol
            [result appendString:amp];
            
            /*
             NSString *unknownEntity = @"";
             [scanner scanUpToString:@";" intoString:&unknownEntity];
             NSString *semicolon = @"";
             [scanner scanString:@";" intoString:&semicolon];
             [result appendFormat:@"%@%@", unknownEntity, semicolon];
             NSLog(@"Unsupported XML character entity %@%@", unknownEntity, semicolon);
             */
        }
        
    }
    while (![scanner isAtEnd]);
    
finish:
    return result;
}

+ (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}


+ (NSString *)getDate
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDate =[ inputFormatter stringFromDate:[NSDate date]];
    
    return currentDate;
}


@end
