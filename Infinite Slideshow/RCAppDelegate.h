//
//  RCAppDelegate.h
//  Infinite Slideshow
//
//  Created by Colin Regan on 1/11/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAssetsLibrary;

@interface RCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 The `ALAssetsLibrary` instance used to fetch photos from the camera roll and photostream
 */
@property (strong, nonatomic) ALAssetsLibrary *library;

@end
