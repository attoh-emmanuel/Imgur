//
//  AboutViewController.m
//  MobiLabTest
//
//  Created by Emmanuel on 4/14/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "AboutViewController.h"
#import "Constants.h"

@interface AboutViewController ()
@property (nonatomic, strong) NSDictionary *appInfo;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.appInfo = [[NSDictionary alloc]initWithDictionary:[[NSBundle mainBundle] infoDictionary]];
    
//     screen containing the app info (version, build time) and author name (email)
    
    NSLog(@"%@",[NSString stringWithFormat:@"Version %@ ", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"BuildTime"]]);
    
    
    NSString *compileDate = [NSString stringWithUTF8String:__DATE__];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM d yyyy"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setLocale:usLocale];
    NSDate *aDate = [df dateFromString:compileDate];
    
    NSLog(@"date %@", aDate);
    
    
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    close.frame = CGRectMake(10, 20, CGRectGetWidth(self.view.frame)/3, 50);
    [close setTitle:@"Close" forState:UIControlStateNormal];
    [close setBackgroundColor:[UIColor grayColor]];
    [close addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:close];
    
    UILabel *label;
    NSString *string = [NSString stringWithFormat:@"Version: %@.%@",self.appInfo[kKeyAppInfoMajorVersion], self.appInfo[kKeyAppInfoMinorVersion]];
    label = [self labelWithY:CGRectGetWidth(self.view.frame)/2 andString:string];
    [self.view addSubview:label];
    
    
    label = [self labelWithY:CGRectGetMaxY(label.frame) andString:kKeyEmail];
    [self.view addSubview:label];
    
}

- (UILabel *)labelWithY:(CGFloat)y andString:(NSString *)text {
     UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, y, CGRectGetWidth(self.view.frame), 50)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:text];
    
    return label;
}

- (void)closeButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
