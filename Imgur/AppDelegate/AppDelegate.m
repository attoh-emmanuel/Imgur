//
//  AppDelegate.m
//  MobiLabTest
//
//  Created by Emmanuel on 4/8/16.
//  Copyright © 2016 Emmanuel. All rights reserved.
//

#import "AppDelegate.h"
#import "SessionManager.h"
#import "Constants.h"
#import "SideBarView.h"

@interface AppDelegate ()
@property (nonatomic, strong) SideBarView *sideBar;
@property (nonatomic) BOOL isSideBarShowing;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [SessionManager authenticateApplicationWithClientID:IMGUR_CLIENT_ID];
    [self setupSideBar];
    
    [IMGRequestGallery sharedInstance];
    
//    [[SessionManager sharedInstance] test];
    return YES;
}

- (void) setupSideBar {
    //sidebar setup
    UIScreenEdgePanGestureRecognizer *rightEdgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(callSideBar)];
    rightEdgeGesture.edges = UIRectEdgeRight;
    [self.window addGestureRecognizer:rightEdgeGesture];
}

- (void) callSideBar {
    if (!self.sideBar) {
        
        self.sideBar = [[SideBarView alloc]initWithFrame:CGRectMake(self.window.frame.size.width, 15, 350.0, CGRectGetHeight(self.window.frame))];
        self.sideBar.backgroundColor = [UIColor lightGrayColor];
        
        UISwipeGestureRecognizer *sideBarClose = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(closeSideBar)];
        [sideBarClose setDirection:UISwipeGestureRecognizerDirectionRight];
        [self.sideBar addGestureRecognizer:sideBarClose];
        
        [self.window addSubview:self.sideBar];
        self.isSideBarShowing = YES;
    }
    
    [UIView animateWithDuration:0.6 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        CGRect frame = self.sideBar.frame;
        frame.origin.x = self.window.frame.size.width - 300.0;
        self.sideBar.frame = frame;
    } completion:NULL];

}

- (void) closeSideBar {
    
    if (self.sideBar) {
        [UIView animateWithDuration:0.4 animations:^{
            
            CGFloat centerX = self.window.frame.size.width + (self.sideBar.frame.size.width / 2.0);
            CGFloat centerY = self.sideBar.center.y;
            self.sideBar.center = CGPointMake(centerX, centerY);
        } completion:^(BOOL finished) {
            
            self.sideBar = nil;
            self.isSideBarShowing = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:kKeySideBarNotification object:nil];
        }];
    }
}

+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
@end
