//
//  RCPhotoAlbum.h
//  Infinite Slideshow
//
//  Created by Colin Regan on 1/16/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAssetsLibrary;
@class ALAssetsGroup;
typedef NSUInteger ALAssetsGroupType;

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

@property (nonatomic, strong) ALAssetsLibrary *library;
@property (nonatomic, strong) NSArray *loadedAssets;

@end
