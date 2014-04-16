//
//  RCViewController.h
//  Infinite Slideshow
//
//  Created by Colin Regan on 1/11/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCPhotoAlbum.h"
#import "KASlideShow.h"

@interface RCSlideshowViewController : UIViewController <KASlideShowDataSource, KASlideShowDelegate, RCPhotoAlbumDelegate>

@property (weak, nonatomic) IBOutlet KASlideShow *slideShowView;

@property (strong, nonatomic) RCPhotoAlbum *photoAlbum;

@end
