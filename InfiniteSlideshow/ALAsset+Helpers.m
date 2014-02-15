//
//  ALAsset+Helpers.m
//  InfiniteSlideshow
//
//  Created by Colin Regan on 2/15/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import "ALAsset+Helpers.h"

@implementation ALAsset (Helpers)

- (UIImage *)image
{
    ALAssetRepresentation *rep = [self defaultRepresentation];
    CGImageRef imageRef = rep ? [rep fullScreenImage] : [self aspectRatioThumbnail];
    return [UIImage imageWithCGImage:imageRef];
}

@end
