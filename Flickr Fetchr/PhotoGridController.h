//
//  ViewController.h
//  Flickr Fetchr
//
//  Created by Tejas Ranade on 5/6/15.
//  Copyright (c) 2015 Tejas Ranade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrPhotoLoader.h"

@interface PhotoGridController : UIViewController <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, FlickrPhotoLoaderDelegate>

@end

