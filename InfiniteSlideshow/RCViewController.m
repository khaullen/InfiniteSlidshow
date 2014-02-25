//
//  RCViewController.m
//  Infinite Slideshow
//
//  Created by Colin Regan on 1/11/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import "RCViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAsset+Helpers.h"

static NSString *const kRCHardcodedGroupName = @"Internet";

@interface RCViewController ()

@property (nonatomic, assign) NSUInteger index;

@end

@implementation RCViewController

#pragma mark - Initialization

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.slideShowView.imagesContentMode = UIViewContentModeScaleAspectFit;
    self.slideShowView.delay = 30.f;
    self.slideShowView.dataSource = self;
    self.slideShowView.delegate = self;

    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    self.photoAlbum = [[RCPhotoAlbum alloc] initWithLibrary:library groupName:kRCHardcodedGroupName];
    self.photoAlbum.delegate = self;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

#pragma mark - KASlideShowDataSource

- (UIImage *)slideShow:(KASlideShow *)slideShow imageForPosition:(KASlideShowPosition)position
{
    NSUInteger index;
    switch ([self.photoAlbum.loadedAssets count]) {
        case 0: return nil;
        case 1: index = 0;
            break;
        default: index = (self.index + position) % [self.photoAlbum.loadedAssets count];
            break;
    }
    if (!position) self.index = index;  // Update self.index to the count-adjusted index to prevent counting to infinity
    ALAsset *asset = [self.photoAlbum.loadedAssets objectAtIndex:index];
    return [asset image];
}

#pragma mark - KASlideShowDelegate

- (void)kaSlideShowWillShowNext:(KASlideShow *)slideShow
{
    if ([slideShow isEqual:self.slideShowView]) self.index++;
}

- (void)kaSlideShowWillShowPrevious:(KASlideShow *)slideShow
{
    if ([slideShow isEqual:self.slideShowView]) self.index--;
}

#pragma mark - RCPhotoAlbumDelegate

- (void)photoAlbumDidUpdate:(RCPhotoAlbum *)album
{
    if (self.slideShowView.state == KASlideShowStateStopped && album.loadedAssets.count > 0) [self.slideShowView start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
