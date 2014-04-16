//
//  RCLibraryViewController.m
//  InfiniteSlideshow
//
//  Created by Colin Regan on 4/15/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import "RCLibraryViewController.h"

@interface RCLibraryViewController ()

@end

@implementation RCLibraryViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSegueWithIdentifier:@"segueToSlideshow" sender:nil];
}

@end
