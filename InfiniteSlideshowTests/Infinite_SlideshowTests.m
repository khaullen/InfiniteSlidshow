//
//  Infinite_SlideshowTests.m
//  Infinite SlideshowTests
//
//  Created by Colin Regan on 1/11/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RCAppDelegate.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface TCAssetsLibrary : ALAssetsLibrary

@property BOOL success;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;

- (instancetype)initWithSuccess:(BOOL)success;

@end

@implementation TCAssetsLibrary

- (instancetype)initWithSuccess:(BOOL)success
{
    self = [super init];
    if (self) {
        self.success = success;
        self.semaphore = dispatch_semaphore_create(0);
    }
    return self;
}

- (void)enumerateGroupsWithTypes:(ALAssetsGroupType)types usingBlock:(ALAssetsLibraryGroupsEnumerationResultsBlock)enumerationBlock failureBlock:(ALAssetsLibraryAccessFailureBlock)failureBlock
{
    NSError *error;
    switch (types) {
        case ALAssetsGroupPhotoStream:
            if (self.success) {
                NSArray *groups = @[[[ALAssetsGroup alloc] init],
                                    [[ALAssetsGroup alloc] init],
                                    [[ALAssetsGroup alloc] init]];
                [groups enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    enumerationBlock(obj, stop);
                }];
            } else {
                error = [NSError errorWithDomain:ALAssetsLibraryErrorDomain code:-3311 userInfo:@{NSLocalizedDescriptionKey: @"User denied access", NSUnderlyingErrorKey: [NSError errorWithDomain:ALAssetsLibraryErrorDomain code:-3311 userInfo:@{NSLocalizedDescriptionKey: @"The operation couldn’t be completed"}], NSLocalizedFailureReasonErrorKey: @"The user has denied the application access to their media"}];
                failureBlock(error);
                dispatch_semaphore_signal(self.semaphore);
            }
            break;
            
        default:
            break;
    }
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
    TCAssetsLibrary *library = [[TCAssetsLibrary alloc] initWithSuccess:NO];
    RCAppDelegate *appDelegate = (RCAppDelegate *)[[UIApplication sharedApplication] delegate];
    dispatch_async(dispatch_queue_create("appDelegate", NULL), ^{
        appDelegate.library = library;
    });
    dispatch_semaphore_wait(library.semaphore, dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC));
    XCTAssertNil(appDelegate.photoAlbums);
    XCTAssertFalse(appDelegate.isAuthorized);
    XCTAssertEqual(appDelegate.authorizationError.code, (NSInteger)-3311);
    XCTAssertNotEqual(appDelegate.authorizationError.code, 55);
}

- (void)testUserApprovesAccess
{
    TCAssetsLibrary *library = [[TCAssetsLibrary alloc] initWithSuccess:YES];
    RCAppDelegate *appDelegate = (RCAppDelegate *)[[UIApplication sharedApplication] delegate];
    dispatch_async(dispatch_queue_create("appDelegate", NULL), ^{
        appDelegate.library = library;
    });
    dispatch_semaphore_wait(library.semaphore, dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC));
    XCTAssertEqual(appDelegate.photoAlbums.count, (NSUInteger)3);
    XCTAssertTrue(appDelegate.isAuthorized);
    XCTAssertNil(appDelegate.authorizationError);
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



//- (void)testSlideshowStartsOnAppLaunch
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}
//
//- (void)testAppLoadsCorrectPhotoAlbum
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}

@end
