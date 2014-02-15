//
//  RCViewController.m
//  Infinite Slideshow
//
//  Created by Colin Regan on 1/11/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import "RCViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "KASlideShow.h"

static NSString *const kRCHardcodedGroupName = @"Patterns";

@interface RCViewController ()

@end

@implementation RCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.slideShowView.imagesContentMode = UIViewContentModeScaleAspectFit;

    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    self.photoAlbum = [[RCPhotoAlbum alloc] initWithLibrary:library groupName:kRCHardcodedGroupName];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

- (void)setPhotoAlbum:(RCPhotoAlbum *)photoAlbum
{
    if (_photoAlbum != photoAlbum) {
        _photoAlbum = photoAlbum;
        photoAlbum.delegate = self;
    }
}

- (void)photoAlbum:(RCPhotoAlbum *)album didLoadNewPhotos:(NSArray *)photos
{
    for (UIImage *image in photos) {
        [self.slideShowView addImage:image];
    }
    [self.slideShowView start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
