//
//  RCPhotoAlbum.m
//  Infinite Slideshow
//
//  Created by Colin Regan on 1/16/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import "RCPhotoAlbum.h"
#import <AssetsLibrary/AssetsLibrary.h>

static NSString *const kRCAlertViewTitle = @"Warning";
static NSString *const kRCAlertViewCancelButtonTitle = @"OK";
static NSString *const kRCGroupNotFoundMessage = @"The designated photo album was not found";
static NSString *const kRCUserDeniedAccessMessage = @"This app requires photo library access";

@interface RCPhotoAlbum ()

@property (strong, nonatomic) NSMutableArray *loadedPhotos;

- (void)assetsChanged:(NSNotification *)notification;
- (void)loadImagesFromSource:(ALAssetsGroup *)source;

@end

@implementation RCPhotoAlbum

#pragma mark - Initialization

- (instancetype)initWithLibrary:(ALAssetsLibrary *)library groupName:(NSString *)groupName
{
    self = [super init];
    if (self) {
        self.loadedPhotos = [NSMutableArray new];
        if (library) {
            self.library = library;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(assetsChanged:) name:ALAssetsLibraryChangedNotification object:library];
            [library enumerateGroupsWithTypes:ALAssetsGroupPhotoStream usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                NSString *name = [group valueForProperty:ALAssetsGroupPropertyName];
                if ([groupName isEqualToString:name]) {
                    self.source = group;
                    *stop = YES;
                } else if (!group && !*stop) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kRCAlertViewTitle message:kRCGroupNotFoundMessage delegate:self cancelButtonTitle:kRCAlertViewCancelButtonTitle otherButtonTitles:nil];
                    [alert show];
                }
            } failureBlock:^(NSError *error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kRCAlertViewTitle message:kRCUserDeniedAccessMessage delegate:self cancelButtonTitle:kRCAlertViewCancelButtonTitle otherButtonTitles:nil];
                [alert show];
            }];
        }
    }
    return self;
}

- (instancetype)init
{
    return [self initWithLibrary:nil groupName:nil];
}

#pragma mark - Image loading

- (void)setSource:(ALAssetsGroup *)source
{
    if (_source != source) {
        _source = source;
        [self loadImagesFromSource:source];
    }
}

- (void)loadImagesFromSource:(ALAssetsGroup *)source
{
    NSMutableArray *photos = [NSMutableArray new];
    [source enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                if (![self.loadedPhotos containsObject:result]) {
                    ALAssetRepresentation *rep = [result defaultRepresentation];
                    CGImageRef imageRef = rep ? [rep fullScreenImage] : [result aspectRatioThumbnail];
                    UIImage *image = [UIImage imageWithCGImage:imageRef];
                    if (image) {
                        [photos addObject:image];
                        [self.loadedPhotos addObject:result];
                    }
                }
            }
        }
    }];
    [self.delegate photoAlbum:self didLoadNewPhotos:photos];
}

#pragma mark - Properties

- (NSString *)name
{
    return [self.source valueForProperty:ALAssetsGroupPropertyName];
}

- (ALAssetsGroupType)type
{
    return [[self.source valueForProperty:ALAssetsGroupPropertyType] unsignedIntegerValue];
}

- (NSString *)persistentID
{
    return [self.source valueForProperty:ALAssetsGroupPropertyPersistentID];
}

- (NSURL *)url
{
    return [self.source valueForProperty:ALAssetsGroupPropertyURL];
}

#pragma mark - Notifications

- (void)assetsChanged:(NSNotification *)notification
{
    NSSet *updatedGroups = notification.userInfo[ALAssetLibraryUpdatedAssetGroupsKey];
    if ([updatedGroups containsObject:self.url]) {
        [self loadImagesFromSource:self.source];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
