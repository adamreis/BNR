//
//  AHRAppDelegate.m
//  Hypnosister
//
//  Created by Adam Reis on 5/26/14.
//  Copyright (c) 2014 Adam Reis. All rights reserved.
//
//  Based on example code from the Big Nerd Ranch Guide to iOS programming

#import "AHRAppDelegate.h"
#import "AHRHypnosisView.h"

@implementation AHRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    CGRect screenRect = self.window.bounds;
    CGRect biggerRect = screenRect;
    biggerRect.size.width *= 2;
    
    // Screen-sized scroll view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    
    AHRHypnosisView *firstHypnosisView  = [[AHRHypnosisView alloc] initWithFrame:screenRect];
    screenRect.origin.x += screenRect.size.width;
    AHRHypnosisView *secondtHypnosisView  = [[AHRHypnosisView alloc] initWithFrame:screenRect];

    [scrollView addSubview:firstHypnosisView];
    [scrollView addSubview:secondtHypnosisView];
    [self.window addSubview:scrollView];
    scrollView.contentSize = biggerRect.size;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
