//
//  AppDelegate.m
//  HappyDel
//
//  Created by NL on 15-1-14.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "AppDelegate.h"
#import "HappyDAO.h"
#import <objc/runtime.h>

@interface AppDelegate ()<UIAlertViewDelegate>

@end

@implementation AppDelegate

#ifdef DEBUG
FILE *fopen$UNIX2003(const char *filename, const char *mode) {
    return fopen(filename, mode);
}

size_t fwrite$UNIX2003(const void *ptr, size_t size, size_t nitems, FILE *stream) {
    return fwrite(ptr, size, nitems, stream);
}
#endif


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [gHappyDAO initDatabase];
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    NSLog(@"apps: %@", [workspace performSelector:@selector(allApplications)]);
    return YES;
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
////    NSLog(@"调用的应用程序的Bundle ID是: %@", sourceApplication);
//    NSLog(@"URL scheme:%@", [url scheme]);
//    NSLog(@"URL query: %@", [url query]);
//    return YES;
//}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([sourceApplication isEqualToString:@"com.b.yixin.FengNiao.dev"])
    {
        NSLog(@"调用的应用程序的Bundle ID是: %@", sourceApplication);
        NSLog(@"URL scheme:%@", [url scheme]);
        NSLog(@"URL query: %@", [url query]);
        if ([[url query] isEqualToString:@"back"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"是否返回企业易信" delegate:self cancelButtonTitle:@"留下" otherButtonTitles:@"返回企业易信", nil];
            [alert show];
        }
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.cancelButtonIndex) {
        
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"yixinwork://"]];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
