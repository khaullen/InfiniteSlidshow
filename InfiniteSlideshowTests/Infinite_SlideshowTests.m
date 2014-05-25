//
//  Infinite_SlideshowTests.m
//  Infinite SlideshowTests
//
//  Created by Colin Regan on 1/11/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "RCPhotoAlbum.h"
#import "RCPhotoLibrary.h"

@interface TCAssetsLibrarySuccess : ALAssetsLibrary

@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation TCAssetsLibrarySuccess

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.semaphore = dispatch_semaphore_create(0);
    }
    return self;
}

- (void)enumerateGroupsWithTypes:(ALAssetsGroupType)types usingBlock:(ALAssetsLibraryGroupsEnumerationResultsBlock)enumerationBlock failureBlock:(ALAssetsLibraryAccessFailureBlock)failureBlock
{
    NSArray *groups = @[[[ALAssetsGroup alloc] init],
                        [[ALAssetsGroup alloc] init],
                        [[ALAssetsGroup alloc] init]];
    [groups enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        enumerationBlock(obj, stop);
    }];
    enumerationBlock(nil, NULL);
    dispatch_semaphore_signal(self.semaphore);
}

+ (ALAuthorizationStatus)authorizationStatus
{
    return ALAuthorizationStatusAuthorized;
}

@end

@interface TCAssetsLibraryFailure : ALAssetsLibrary

@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation TCAssetsLibraryFailure

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.semaphore = dispatch_semaphore_create(0);
    }
    return self;
}

- (void)enumerateGroupsWithTypes:(ALAssetsGroupType)types usingBlock:(ALAssetsLibraryGroupsEnumerationResultsBlock)enumerationBlock failureBlock:(ALAssetsLibraryAccessFailureBlock)failureBlock
{
    NSError *error = [NSError errorWithDomain:ALAssetsLibraryErrorDomain code:-3311 userInfo:@{NSLocalizedDescriptionKey: @"User denied access", NSUnderlyingErrorKey: [NSError errorWithDomain:ALAssetsLibraryErrorDomain code:-3311 userInfo:@{NSLocalizedDescriptionKey: @"The operation couldn’t be completed"}], NSLocalizedFailureReasonErrorKey: @"The user has denied the application access to their media"}];
    failureBlock(error);
    dispatch_semaphore_signal(self.semaphore);
}

+ (ALAuthorizationStatus)authorizationStatus
{
    return ALAuthorizationStatusDenied;
}

@end

@interface Infinite_SlideshowTests : XCTestCase

@end

@implementation Infinite_SlideshowTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUserDeniesAccess
{
    TCAssetsLibraryFailure *library = [[TCAssetsLibraryFailure alloc] init];
    __block RCPhotoLibrary *photoLibrary;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        photoLibrary = [[RCPhotoLibrary alloc] initWithAssetsLibrary:library];
    });
    dispatch_semaphore_wait(library.semaphore, DISPATCH_TIME_FOREVER);
    XCTAssertEqual(photoLibrary.allAlbums.count, (NSUInteger)0);
    XCTAssertFalse(photoLibrary.isAuthorized);
    XCTAssertEqual(photoLibrary.authorizationError.code, (NSInteger)-3311);
    XCTAssertNotEqual(photoLibrary.authorizationError.code, 55);
}

- (void)testUserApprovesAccess
{
    TCAssetsLibrarySuccess *library = [[TCAssetsLibrarySuccess alloc] init];
    __block RCPhotoLibrary *photoLibrary;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        photoLibrary = [[RCPhotoLibrary alloc] initWithAssetsLibrary:library];
    });
    dispatch_semaphore_wait(library.semaphore, DISPATCH_TIME_FOREVER);
    XCTAssertEqual([photoLibrary.allAlbums count], (NSUInteger)3);
    XCTAssertTrue(photoLibrary.isAuthorized);
    XCTAssertNil(photoLibrary.authorizationError);
}

// Testing asynchronous methods:
// Dependency injection -- inject mock ALAssetsLibrary object into RCPhotoAlbum
// Subclass ALAssetsLibrary and override all its public methods to call either success or failure block immediately with mock data
// Subclasses provide public semaphore properties for each method indicating when they've been called
// Overridden methods call the success (or failure) block passed by class under test using mock data, then signal semaphore
// Test methods wait on the corresponding semaphore, then check the side effects on class under test

@end
