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

@end

@implementation RCPhotoAlbum

- (instancetype)initWithLibrary:(ALAssetsLibrary *)library groupName:(NSString *)groupName
{
    self = [super init];
    if (self) {
        if (library) {
            self.library = library;
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

- (void)setSource:(ALAssetsGroup *)source
{
    if (_source != source) {
        _source = source;
        NSMutableArray *photos = [NSMutableArray new];
        [source enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                    ALAssetRepresentation *rep = [result defaultRepresentation];
                    CGImageRef imageRef = rep ? [rep fullScreenImage] : [result aspectRatioThumbnail];
                    UIImage *image = [UIImage imageWithCGImage:imageRef];
                    if (image) [photos addObject:image];
                }
            }
        }];
        [self.delegate photoAlbum:self didLoadNewPhotos:photos];
    }
}

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

@end
