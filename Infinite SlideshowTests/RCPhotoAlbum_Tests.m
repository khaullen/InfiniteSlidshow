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

@interface TCAssetsLibrary : ALAssetsLibrary

@end

@implementation TCAssetsLibrary

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

- (void)testInitWithGroupURL
{
    NSURL *groupURL = [NSURL URLWithString:@"test"];
    RCPhotoAlbum *album = [[RCPhotoAlbum alloc] initWithGroupURL:groupURL];
    XCTAssertEqualObjects(album.groupURL, groupURL);
}

- (void)testInitWithSource
{
    TCAssetsLibrary *library = [[TCAssetsLibrary alloc] init];
    RCPhotoAlbum *album = [[RCPhotoAlbum alloc] initWithSource:library];
    XCTAssertEqualObjects(album.source, library);
}

- (void)testSemaphore
{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [NSThread sleepForTimeInterval:3.0f];
        dispatch_semaphore_signal(sema);
    });
    dispatch_async(dispatch_queue_create("1", NULL), ^{
        [NSThread sleepForTimeInterval:1.0f];
        NSLog(@"1");
    });
    dispatch_async(dispatch_queue_create("2", NULL), ^{
        [NSThread sleepForTimeInterval:2.0f];
        NSLog(@"2");
    });
    dispatch_async(dispatch_queue_create("3", NULL), ^{
        [NSThread sleepForTimeInterval:3.0f];
        NSLog(@"3");
    });
    NSLog(@"Waiting...");
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    NSLog(@"Finished.");
    XCTAssertTrue(YES);
}

// Idea for testing asynchronous methods:
// Dependency injection -- inject mock ALAssetsLibrary object into RCPhotoAlbum
// Subclass ALAssetsLibrary and override all its public methods to call either success or failure block immediately with mock data
// Subclasses provide public semaphore properties for each method indicating when they've been called
// Overridden methods call the success (or failure) block passed by class under test using mock data, then signal semaphore
// Test methods wait on the corresponding semaphore, then check the side effects on class under test

@end
