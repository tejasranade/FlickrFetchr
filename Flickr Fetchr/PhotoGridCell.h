//
//  PhotoGridCell.h
//  Flickr Fetchr
//
//  Created by Tejas Ranade on 5/6/15.
//  Copyright (c) 2015 Tejas Ranade. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlickrPhoto;

@interface PhotoGridCell : UICollectionViewCell
@property (nonatomic, weak) IBOutlet UIImageView* photoView;
@property (nonatomic, strong) FlickrPhoto* photo;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView* loadingSpinner;
- (void) loadImage;
@end
