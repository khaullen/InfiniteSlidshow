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

@property (nonatomic, readonly) NSArray *allAlbums;
@property (nonatomic, readonly) NSError *authorizationError;
@property (nonatomic, readonly, getter = isAuthorized) BOOL authorized;

+ (instancetype)defaultLibrary;
- (instancetype)initWithAssetsLibrary:(ALAssetsLibrary *)library;

@end
