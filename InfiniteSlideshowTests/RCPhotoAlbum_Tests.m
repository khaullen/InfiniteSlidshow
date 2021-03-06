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

@interface TCAssetRepresentation : ALAssetRepresentation

@end

@implementation TCAssetRepresentation

- (CGImageRef)fullScreenImage
{
    return [[UIImage imageNamed:@"Loopback"] CGImage];
}

@end

@interface TCAsset : ALAsset

@end

@implementation TCAsset

- (ALAssetRepresentation *)defaultRepresentation
{
    return [[TCAssetRepresentation alloc] init];
}

- (id)valueForProperty:(NSString *)property
{
    if ([property isEqualToString:ALAssetPropertyType]) return ALAssetTypePhoto;
    return [super valueForProperty:property];
}

@end

@interface TCAssetsGroup : ALAssetsGroup

@end

@implementation TCAssetsGroup

- (void)enumerateAssetsUsingBlock:(ALAssetsGroupEnumerationResultsBlock)enumerationBlock
{
    NSArray *assets = @[[[TCAsset alloc] init],
                        [[TCAsset alloc] init],
                        [[TCAsset alloc] init]];
    [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        enumerationBlock(obj, idx, stop);
    }];
    enumerationBlock(nil, NSNotFound, NULL);
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

- (void)testThatPhotosArrayIsPopulatedWithUIImageObjects
{
    self.album.source = [[TCAssetsGroup alloc] init];
    XCTAssertTrue([[self.album.photos lastObject] isKindOfClass:[UIImage class]]);
}

@end
