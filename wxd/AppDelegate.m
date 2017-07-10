//
//  AppDelegate.m
//  wxd
//
//  Created by administrator on 2017/7/4.
//  Copyright © 2017年 XD. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()


/**
 *
 */
@property (nonatomic ,strong) NSTimer  * time;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
   
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
    _time = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(point) userInfo:nil repeats:YES];
        
    [[NSRunLoop currentRunLoop] addTimer:_time forMode:NSRunLoopCommonModes];
    });
    
    NSLog(@"1");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    NSLog(@"2");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   
     NSLog(@"3");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)point {
    
    NSLog(@"11");
    
}

@end
