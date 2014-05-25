//
//  RCPhotoLibrary.m
//  InfiniteSlideshow
//
//  Created by Colin Regan on 2/24/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import "RCPhotoLibrary.h"
#import "RCPhotoAlbum.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface RCPhotoLibrary ()

@property (nonatomic, strong, readwrite) ALAssetsLibrary *library;

@property (nonatomic, strong, readwrite) NSArray *allAlbums;
@property (nonatomic, strong, readwrite) NSError *authorizationError;

- (void)libraryChanged:(NSNotification *)notification;

@end

@implementation RCPhotoLibrary

+ (instancetype)defaultLibrary
{
    static dispatch_once_t onceToken;
    static RCPhotoLibrary *defaultLibrary;
    dispatch_once(&onceToken, ^{
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        defaultLibrary = [[[self class] alloc] initWithAssetsLibrary:assetsLibrary];
    });
    return defaultLibrary;
}

- (instancetype)initWithAssetsLibrary:(ALAssetsLibrary *)library
{
    self = [super init];
    if (self) {
        self.library = library;
    }
    return self;
}

- (void)setLibrary:(ALAssetsLibrary *)library
{
    if (_library != library) {
        _library = library;
        if (library) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(libraryChanged:) name:ALAssetsLibraryChangedNotification object:library];
            NSMutableArray *allAlbums = [NSMutableArray array];
            [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                // Create RCPhotoAlbum instance with each group, and add them all to an array
                if (group) {
                    [allAlbums addObject:group];
                } else {
                    self.allAlbums = [allAlbums copy];
                }
                
            } failureBlock:^(NSError *error) {
                self.authorizationError = error;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Warning", nil) message:NSLocalizedString(@"This app requires photo library access", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                [alert show];
            }];
        }
    }
}

#pragma mark - Properties

- (BOOL)isAuthorized
{
    return [[self.library class] authorizationStatus] == ALAuthorizationStatusAuthorized;
}

#pragma mark - NSNotification selectors

- (void)libraryChanged:(NSNotification *)notification
{
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALAssetsLibraryChangedNotification object:self.library];
}

@end
