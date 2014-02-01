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

static NSString *const kRCHardcodedGroupName = @"";
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

    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupPhotoStream usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        NSString *name = [group valueForProperty:ALAssetsGroupPropertyName];
        if ([name isEqualToString:kRCHardcodedGroupName]) {
            self.photoAlbum = [[RCPhotoAlbum alloc] initWithSource:group];
            *stop = YES;
        } else if (!group) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kRCAlertViewTitle message:kRCGroupNotFoundMessage delegate:self cancelButtonTitle:kRCAlertViewCancelButtonTitle otherButtonTitles:nil];
            [alert show];
        }
    } failureBlock:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kRCAlertViewTitle message:kRCUserDeniedAccessMessage delegate:self cancelButtonTitle:kRCAlertViewCancelButtonTitle otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
