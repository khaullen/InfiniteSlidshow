//
//  RCLibraryViewController.m
//  InfiniteSlideshow
//
//  Created by Colin Regan on 4/15/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import "RCLibraryViewController.h"
#import "RCPhotoLibrary.h"
#import <CHTCollectionViewWaterfallLayout.h>

static NSString *const RCAlbumCell = @"RCAlbumCell";

@interface RCLibraryViewController () <CHTCollectionViewDelegateWaterfallLayout>

@end

@implementation RCLibraryViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.library = [RCPhotoLibrary defaultLibrary];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RCAlbumCell forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0: cell.backgroundColor = [UIColor yellowColor];
            break;
        case 1: cell.backgroundColor = [UIColor greenColor];
            break;
        default: cell.backgroundColor = [UIColor lightGrayColor];
            break;
    }
    return cell;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout protocol

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}

@end
