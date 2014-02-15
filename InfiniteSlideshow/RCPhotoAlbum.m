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
        NSMutableArray *photos = [NSMutableArray new];
        [source enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                    ALAssetRepresentation *rep = [result defaultRepresentation];
                    CGImageRef imageRef = rep ? [rep fullScreenImage] : [result aspectRatioThumbnail];
                    UIImage *image = [UIImage imageWithCGImage:imageRef];
                    if (image) [photos addObject:image];
                }
            }
        }];
        [self.delegate photoAlbum:self didLoadNewPhotos:photos];
    }
}

- (NSString *)name
{
    return [self.source valueForProperty:ALAssetsGroupPropertyName];
}

- (ALAssetsGroupType)type
{
    return [[self.source valueForProperty:ALAssetsGroupPropertyType] unsignedIntegerValue];
}

- (NSString *)persistentID
{
    return [self.source valueForProperty:ALAssetsGroupPropertyPersistentID];
}

- (NSURL *)url
{
    return [self.source valueForProperty:ALAssetsGroupPropertyURL];
}

@end
