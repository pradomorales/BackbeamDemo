//
//  AppDelegate.m
//  DemoLugares
//
//  Created by Backbeam Prototypr on 10/2/2013.
//  Copyright (c) 2013 uclm. All rights reserved.
//

#import "AppDelegate.h"
#import <Backbeam.h>

#import "MapViewController.h"
#import "PlacesViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [Backbeam setProject:@"places" sharedKey:@"dev_df972b7265a8527cda1094849bfcc152f85a6df7" secretKey:@"dev_5a24ace68e70cec97ee8095354e37f5dcfe244daffbbf00a055b549bccf88047400c46bff27b04d9" environment:@"dev"];


    UITabBarController *tab = [[UITabBarController alloc] init];
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    UIViewController *controller = nil;
    UINavigationController *navController = nil;


    controller = [[MapViewController alloc] init];
    navController = [[UINavigationController alloc] initWithRootViewController:controller];
    navController.title = @"Mapa";
    navController.tabBarItem.image = [UIImage imageNamed:@"adventures"];
    [viewControllers addObject:navController];
    
    controller = [[PlacesViewController alloc] init];
    navController = [[UINavigationController alloc] initWithRootViewController:controller];
    navController.title = @"Lugares";
    navController.tabBarItem.image = [UIImage imageNamed:@"contacts"];
    
    [viewControllers addObject:navController];

    tab.viewControllers = viewControllers;
    self.window.rootViewController = tab;

    
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
