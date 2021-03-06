//
//  RCAppDelegate.m
//  Infinite Slideshow
//
//  Created by Colin Regan on 1/11/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import "RCAppDelegate.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "RCPhotoAlbum.h"

static NSString *const kHardcodedAlbumName = @"test";

@interface RCAppDelegate ()

@property (readwrite, nonatomic) NSArray *photoAlbums;
@property (readwrite, nonatomic) NSError *authorizationError;

@end

@implementation RCAppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    application.idleTimerDisabled = YES;
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

#pragma mark - Custom code

- (void)setLibrary:(ALAssetsLibrary *)library
{
    if (_library != library) {
        _library = library;
        self.photoAlbums = nil;
        self.authorizationError = nil;
        NSMutableArray *groups = [NSMutableArray new];
        [library enumerateGroupsWithTypes:ALAssetsGroupPhotoStream usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (group) [groups addObject:group];
        } failureBlock:^(NSError *error) {
            self.authorizationError = error;
        }];
        self.photoAlbums = groups;
    }
}

- (BOOL)isAuthorized
{
    return [[self.library class] authorizationStatus] == ALAuthorizationStatusAuthorized;
}

@end
