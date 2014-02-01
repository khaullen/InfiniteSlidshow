//
//  RCViewController.h
//  Infinite Slideshow
//
//  Created by Colin Regan on 1/11/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KASlideShow;
@class RCPhotoAlbum;

@interface RCViewController : UIViewController

@property (weak, nonatomic) IBOutlet KASlideShow *slideShowView;

@property (strong, nonatomic) RCPhotoAlbum *photoAlbum;

@end
