//
//  RCPhotoAlbum_Tests.m
//  Infinite Slideshow
//
//  Created by Colin Regan on 1/16/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RCPhotoAlbum.h"

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

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
