//
//  Functions.m
//  MobiLabTest
//
//  Created by Emmanuel on 4/14/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "Functions.h"
#import "AppDelegate.h"
#import <MBProgressHUD/MBProgressHUD.h>


@implementation Functions

+ (void)displayLoading {
    [MBProgressHUD showHUDAddedTo:[AppDelegate appDelegate].window animated:YES];
}

+ (void)dismissLoading {
    [MBProgressHUD hideHUDForView:[AppDelegate appDelegate].window animated:YES];
}



@end
