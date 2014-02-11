//
//  RCViewController.m
//  Infinite Slideshow
//
//  Created by Colin Regan on 1/11/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import "RCViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "RCPhotoAlbum.h"
#import "KASlideShow.h"

static NSString *const kRCHardcodedGroupName = @"Hacker School";
static NSString *const kRCAlertViewTitle = @"Warning";
static NSString *const kRCAlertViewCancelButtonTitle = @"OK";
static NSString *const kRCGroupNotFoundMessage = @"The designated photo album was not found";
static NSString *const kRCUserDeniedAccessMessage = @"This app requires photo library access";

@interface RCViewController ()

@end

@implementation RCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.slideShowView.imagesContentMode = UIViewContentModeScaleAspectFit;

    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupPhotoStream usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        NSString *name = [group valueForProperty:ALAssetsGroupPropertyName];
        if ([name isEqualToString:kRCHardcodedGroupName]) {
            self.photoAlbum = [[RCPhotoAlbum alloc] initWithSource:group];
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

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

- (void)setPhotoAlbum:(RCPhotoAlbum *)photoAlbum
{
    if (_photoAlbum != photoAlbum) {
        _photoAlbum = photoAlbum;
        self.slideShowView.images = [photoAlbum.photos mutableCopy];
        [self.slideShowView start];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
