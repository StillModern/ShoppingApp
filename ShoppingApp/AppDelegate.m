//
//  AppDelegate.m
//  ShoppingApp
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 Oliver. All rights reserved.
//

#import "AppDelegate.h"
#import "GoodsViewController.h"
#import "ShoppingCarViewController.h"
#import "MineViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    //历史记录
    NSString *lPathDocument = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *lPahtFile = [lPathDocument stringByAppendingPathComponent:@"searchHistory.json"];    
    NSFileManager *lFileManger = [NSFileManager defaultManager];
    if ([lFileManger fileExistsAtPath:lPahtFile]) {
        NSData *lData = [NSData dataWithContentsOfFile:lPahtFile];
        NSArray *lArray = [NSJSONSerialization JSONObjectWithData:lData options:NSJSONReadingAllowFragments error:nil];
        [[ShoppingManager shareShoppingManager].arrayHistory addObjectsFromArray:lArray];
    }
    
    UITabBarController *lTabBarController = [[UITabBarController alloc]init];
    GoodsViewController *lGoodsViewController = [[GoodsViewController alloc]init];
    ShoppingCarViewController *lShoppingCarViewController = [[ShoppingCarViewController alloc]init];
    MineViewController *lMineViewController = [[MineViewController alloc]init];
    lTabBarController.viewControllers = @[lGoodsViewController,lShoppingCarViewController,lMineViewController];
    lTabBarController.tabBar.tintColor = [UIColor blueColor];
    lTabBarController.tabBar.selectedImageTintColor = [UIColor greenColor];
    self.window.rootViewController = lTabBarController;
    
    [lTabBarController release];
    [lGoodsViewController release];
    [lShoppingCarViewController release];
    [lMineViewController release];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    //应用退到后台，把历史记录写入文件
    NSString *lPathDocument = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *lPahtFile = [lPathDocument stringByAppendingPathComponent:@"searchHistory.json"];
    NSData *lData = [NSJSONSerialization dataWithJSONObject:[ShoppingManager shareShoppingManager].arrayHistory options:NSJSONWritingPrettyPrinted error:nil];
    [lData writeToFile:lPahtFile atomically:YES];
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
