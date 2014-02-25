//
//  RCPhotoLibrary.m
//  InfiniteSlideshow
//
//  Created by Colin Regan on 2/24/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import "RCPhotoLibrary.h"

@interface RCPhotoLibrary ()

@property (nonatomic, readwrite) ALAssetsLibrary *library;

@end

@implementation RCPhotoLibrary

- (instancetype)initWithLibrary:(ALAssetsLibrary *)library
{
    self = [super init];
    if (self) {
        self.library = library;
    }
    return self;
}

- (void)setLibrary:(ALAssetsLibrary *)library
{
    if (_library != library) {
        _library = library;
    }
}

@end
