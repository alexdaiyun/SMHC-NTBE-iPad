//
//  AppUtil.m
//  TaxMarksMTM
//
//  Created by dai yun on 14-5-4.
//  Copyright (c) 2014年 alexday. All rights reserved.
//

#import "AppUtil.h"

@implementation AppUtil

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


@end
