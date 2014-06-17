//
//  AppUtil.h
//  TaxMarksMTM
//
//  Created by dai yun on 14-5-4.
//  Copyright (c) 2014年 alexday. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <mach/mach.h>

@interface AppUtil : NSObject



BOOL memoryInfo(vm_statistics_data_t *vmStats);

+ (NSString *)get_MemoryInfo;

+ (void)alignLabelWithTop:(UILabel *)label;

+ (float)heightForTextView: (UITextView *)textView WithText: (NSString *) strText;
+ (BOOL)isValidateMobileNumber:(NSString *)mobileNum;

+ (BOOL)isValidateEmail:(NSString *)email;

@end
