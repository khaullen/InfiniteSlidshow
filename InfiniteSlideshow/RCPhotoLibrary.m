//
//  RCPhotoLibrary.m
//  InfiniteSlideshow
//
//  Created by Colin Regan on 2/24/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import "RCPhotoLibrary.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface RCPhotoLibrary ()

@property (nonatomic, readwrite) ALAssetsLibrary *library;

- (void)libraryChanged:(NSNotification *)notification;

@end

@implementation RCPhotoLibrary

- (instancetype)initWithLibrary:(ALAssetsLibrary *)library
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
            [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                NSString *name = [group valueForProperty:ALAssetsGroupPropertyName];
                NSLog(@"name: %@", name);
                
                // Create RCPhotoAlbum instance with each group, and add them all to an array
                
            } failureBlock:^(NSError *error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Warning", nil) message:NSLocalizedString(@"This app requires photo library access", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                [alert show];
            }];
        }
    }
}

#pragma mark - NSNotification selectors

- (void)libraryChanged:(NSNotification *)notification
{
    
}

@end
