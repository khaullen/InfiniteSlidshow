//
//  RCPhotoAlbum.h
//  Infinite Slideshow
//
//  Created by Colin Regan on 1/16/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAssetsLibrary, ALAssetsGroup, RCPhotoAlbum;
typedef NSUInteger ALAssetsGroupType;

@protocol RCPhotoAlbumDelegate <NSObject>

@optional
- (void)photoAlbumDidUpdate:(RCPhotoAlbum *)album;

@end

/**
 Instances of `RCPhotoAlbum` provide the model layer for accessing a group of photos as an array of `UIImage` objects.
 */
@interface RCPhotoAlbum : NSObject

/**
 The underlying `ALAssetsGroup` to be used as the source of photos.
 */
@property (nonatomic, strong) ALAssetsGroup *source;

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) ALAssetsGroupType type;
@property (nonatomic, readonly) NSString *persistentID;
@property (nonatomic, readonly) NSURL *url;

- (instancetype)initWithLibrary:(ALAssetsLibrary *)library groupName:(NSString *)name;

/**
 The `ALAssetsLibrary` instance used to fetch photos from the camera roll and photostream
 */
@property (nonatomic, strong) ALAssetsLibrary *library;

/**
 An array of photos loaded from the corresponding album in the `ALAssetsLibrary` property `library`
 */
@property (nonatomic, strong) NSArray *loadedAssets;

/**
 A boolean value specifying whether the app is authorized to access the photo library
 */
@property (readonly, nonatomic, getter = isAuthorized) BOOL authorized;

@property (nonatomic, weak) id<RCPhotoAlbumDelegate> delegate;

@end
