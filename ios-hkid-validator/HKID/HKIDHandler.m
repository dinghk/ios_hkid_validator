//
//  HKIDHandler.m
//  ios-hkid-validator
//
//  Created by Ding Lo on 30/4/2021.
//

#import "HKIDHandler.h"

@implementation HKIDHandler

// HKID Validation
+ (void)checkHKIDValid: (NSString *)hkid isValid:(CompletionBlock)completionBlock {
    NSArray *beforeDigitArray = [hkid componentsSeparatedByString:@"("];
    NSString *beforeDigit = [beforeDigitArray objectAtIndex: 0];
    if ([beforeDigit length] > 0) {
        
        NSInteger totalSum = 0;
        NSInteger startNo = 0;
        if ([beforeDigit length] == 7) {
            totalSum += 36 * 9; // Spacing for one alphabet prefixed
            startNo = 8;
        } else if ([beforeDigit length] > 7) {
            startNo = 9;
        } else {
            completionBlock(FALSE);
            return;
        }
        
        for (int i=0; i<[beforeDigit length]; i++) {
            unichar digitChar = [[hkid uppercaseString] characterAtIndex: i];
            if (digitChar >= 'A' && digitChar <= 'Z') {
                NSString *digitString = [NSString stringWithFormat:@"%d",digitChar - 55];
                NSInteger digitNo = [digitString integerValue];
                totalSum += digitNo * (startNo - i);
            } else {
                NSString *digitString = [NSString stringWithFormat:@"%d",digitChar - 48];
                NSInteger digitNo = [digitString integerValue];
                totalSum += digitNo * (startNo - i);
            }
        }
        
        // Remaining
        NSString *lastDigit = 0;
        NSInteger remain = totalSum % 11;
        if (remain == 0) {
            lastDigit = @"0";
        } else if (remain == 1) {
            lastDigit = @"A";
        } else {
            NSInteger lastNo = 11 - remain;
            lastDigit = [NSString stringWithFormat:@"%ld", (long)lastNo];
        }
        
        // Get final Digit
        NSRange searchFromRange = [hkid rangeOfString:@"("];
        NSRange searchToRange = [hkid rangeOfString:@")"];
        if (searchToRange.length != 0 && searchFromRange.length != 0) {
            NSString *digitSub = [hkid substringWithRange:NSMakeRange(searchFromRange.location+searchFromRange.length, searchToRange.location-searchFromRange.location-searchFromRange.length)];
            
            if ([lastDigit isEqualToString: digitSub]) {
                completionBlock(TRUE);
                return;
            } else {
                completionBlock(FALSE);
                return;
            }
        }
    }
    
    completionBlock(FALSE);
    return;
}

@end
