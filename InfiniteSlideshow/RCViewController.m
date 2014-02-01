//
//  RCViewController.m
//  Infinite Slideshow
//
//  Created by Colin Regan on 1/11/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import "RCViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface RCViewController ()

@end

@implementation RCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupPhotoStream usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
    } failureBlock:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"This app requires photo library access" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
