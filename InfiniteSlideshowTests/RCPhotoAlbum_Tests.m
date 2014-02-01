//
//  RCPhotoAlbum_Tests.m
//  Infinite Slideshow
//
//  Created by Colin Regan on 1/16/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RCPhotoAlbum.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface TCAssetsGroup : ALAssetsGroup

@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation TCAssetsGroup

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.semaphore = dispatch_semaphore_create(0);
    }
    return self;
}

- (void)enumerateAssetsUsingBlock:(ALAssetsGroupEnumerationResultsBlock)enumerationBlock
{
    NSArray *assets = @[[[ALAsset alloc] init],
                        [[ALAsset alloc] init],
                        [[ALAsset alloc] init]];
    [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        enumerationBlock(obj, idx, stop);
    }];
    dispatch_semaphore_signal(self.semaphore);
}

@end


@interface RCPhotoAlbum_Tests : XCTestCase

@property (nonatomic, strong) RCPhotoAlbum *album;

@end

@implementation RCPhotoAlbum_Tests

- (void)setUp
{
    [super setUp];
    self.album = [[RCPhotoAlbum alloc] init];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testInitWithSource
{
    ALAssetsGroup *group = [[ALAssetsGroup alloc] init];
    RCPhotoAlbum *album = [[RCPhotoAlbum alloc] initWithSource:group];
    XCTAssertEqualObjects(album.source, group);
}

- (void)testSettingSourcePopulatesPhotosArray
{
    RCPhotoAlbum *album = [[RCPhotoAlbum alloc] init];
    TCAssetsGroup *group = [[TCAssetsGroup alloc] init];
    album.source = group;
    XCTAssertEqual([album.photos count], (NSUInteger)3);
}

@end
