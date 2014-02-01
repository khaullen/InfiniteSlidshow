//
//  RCPhotoAlbum.m
//  Infinite Slideshow
//
//  Created by Colin Regan on 1/16/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import "RCPhotoAlbum.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface RCPhotoAlbum ()

@property (nonatomic, readwrite) NSArray *photos;

@end

@implementation RCPhotoAlbum

- (instancetype)initWithSource:(ALAssetsGroup *)source
{
    self = [super init];
    if (self) {
        self.source = source;
    }
    return self;
}

- (void)setSource:(ALAssetsGroup *)source
{
    if (_source != source) {
        _source = source;
        self.photos = nil;
        NSMutableArray *photos = [NSMutableArray new];
        [source enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) [photos addObject:result];
        }];
        self.photos = photos;
    }
}

@end
