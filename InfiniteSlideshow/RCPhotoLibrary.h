//
//  RCPhotoLibrary.h
//  InfiniteSlideshow
//
//  Created by Colin Regan on 2/24/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAssetsLibrary;

@interface RCPhotoLibrary : NSObject

@property (nonatomic, readonly) ALAssetsLibrary *library;

+ (instancetype)defaultLibrary;
- (instancetype)initWithAssetsLibrary:(ALAssetsLibrary *)library;

@end
