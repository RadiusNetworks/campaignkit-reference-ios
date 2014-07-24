//
//  AppDelegate.m
//  CKReferenceApp
//
//  Created by Scott Yoder on 7/15/14.
//  Copyright (c) 2014 Radius Networks. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DealsViewController.h"
#import <CampaignKit/CampaignKit.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.campaignKitManager = [CKManager managerWithDelegate:self];
    [self.campaignKitManager start];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    CKCampaign* campaign = [_campaignKitManager campaignFromNotification:notification];
    if (campaign)
    {
        [self showCampaign:campaign];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
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

- (void)campaignKit:(CKManager *)manager didFindCampaign:(CKCampaign *)campaign
{
    // if in background, pop the notification
    UIApplication* app = [UIApplication sharedApplication];
    if (app.applicationState != UIApplicationStateActive)
    {
        [app presentLocalNotificationNow:[campaign buildLocalNotification]];
        // app.applicationIconBadgeNumber = 1;
    } else {
        // else if app is open, show alert view
        [CKCampaignAlertView showWithCampaign:campaign andCompletion:^{
            [self showCampaign:campaign];
        }];
    }
}

- (void)campaignKit:(CKManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"CampaignKit error: %@", error);
}

- (void)showCampaign:(CKCampaign*)campaign;
{
    UIViewController* view = [self.window.rootViewController presentedViewController];
    if (view == nil)
    {
        // we must still be on the home view
        [self.window.rootViewController performSegueWithIdentifier:@"deals" sender:self];
        view = [self.window.rootViewController presentedViewController];
    }
        
    if ([view isKindOfClass:[UINavigationController class] ]) {
        UIViewController* topView = [((UINavigationController*)view) topViewController];
        if ([topView isKindOfClass:[DealsViewController class]]) {
            [(DealsViewController*)topView showCampaign: campaign];
        }
    }
}

@end
