//
//  RCLibraryViewController.h
//  InfiniteSlideshow
//
//  Created by Colin Regan on 4/15/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RCPhotoLibrary;

@interface RCLibraryViewController : UICollectionViewController

@property (nonatomic, strong) RCPhotoLibrary *library;

@end
