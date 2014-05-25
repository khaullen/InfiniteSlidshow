//
//  RCPhotoAlbumCell.h
//  InfiniteSlideshow
//
//  Created by Colin Regan on 5/24/14.
//  Copyright (c) 2014 Red Cup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCPhotoAlbumCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UIView *labelBackground;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
