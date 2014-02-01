//
//  RCPhotoAlbum.h
//  Infinite Slideshow
//
//  Created by Colin Regan on 1/16/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAssetsGroup;

/**
 Instances of `RCPhotoAlbum` provide the model layer for accessing a group of photos as an array of `UIImage` objects.
 */
@interface RCPhotoAlbum : NSObject

/**
 The underlying `ALAssetsGroup` to be used as the source of photos.
 */
@property (nonatomic, strong) ALAssetsGroup *source;

/**
 An array of `UIImage` objects derived from the `source` property.
 */
@property (nonatomic, readonly) NSArray *photos;

/**
 Initializes a new instance of `RCPhotoAlbum` with a given `groupURL`.
 
 @param groupURL The URL to be used when fetching photos from the photo library.
 @return A newly created photo album object initialized with the given group URL.
 */
- (instancetype)initWithSource:(ALAssetsGroup *)source;

@end
