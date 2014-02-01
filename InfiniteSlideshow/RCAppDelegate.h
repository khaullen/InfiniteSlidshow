//
//  RCAppDelegate.h
//  Infinite Slideshow
//
//  Created by Colin Regan on 1/11/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAssetsLibrary;
@class RCPhotoAlbum;

@interface RCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 The `ALAssetsLibrary` instance used to fetch photos from the camera roll and photostream
 */
@property (strong, nonatomic) ALAssetsLibrary *library;

/**
 An array of photo albums fetched from the `ALAssetsLibrary` property `library`
 */
@property (readonly, nonatomic) NSArray *photoAlbums;

/**
 A boolean value specifying whether the app is authorized to access the photo library
 */
@property (readonly, nonatomic, getter = isAuthorized) BOOL authorized;

/**
 An error object indicating the reason, if any, that photo library access was denied
 */
@property (readonly, nonatomic) NSError *authorizationError;

/**
 A reference to the hardcoded photo album that will be used for the slideshow
 */
@property (readonly, nonatomic) RCPhotoAlbum *hardcodedAlbum;

@end
