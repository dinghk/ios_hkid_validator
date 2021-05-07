//
//  ViewController.m
//  ios-hkid-validator
//
//  Created by Ding Lo on 30/4/2021.
//

#import "ViewController.h"
#import "HKIDHandler.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // HKID Validator
    NSString *hkid = @"A123456(7)"; // Please update the HKID number.
    [HKIDHandler checkHKIDValid: hkid isValid:^(BOOL isValid) {
        if (isValid) {
            NSLog(@"VALID HKID");
        } else {
            NSLog(@"INVALID HKID");
        }
    }];
}


@end
