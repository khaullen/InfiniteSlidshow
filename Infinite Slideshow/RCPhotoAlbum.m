//
//  RCPhotoAlbum.m
//  Infinite Slideshow
//
//  Created by Colin Regan on 1/16/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import "RCPhotoAlbum.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation RCPhotoAlbum

- (instancetype)initWithGroupURL:(NSURL *)groupURL
{
    self = [super init];
    if (self) {
        self.groupURL = groupURL;
    }
    return self;
}

- (instancetype)initWithSource:(ALAssetsLibrary *)source
{
    self = [super init];
    if (self) {
        self.source = source;
    }
    return self;
}

@end
