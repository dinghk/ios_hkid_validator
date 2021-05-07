//
//  HKIDHandler.h
//  ios-hkid-validator
//
//  Created by Ding Lo on 30/4/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HKIDHandler : NSObject
typedef void (^CompletionBlock)(BOOL isValid);

+ (void)checkHKIDValid: (NSString *)hkid isValid:(CompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END
