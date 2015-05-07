//
//  PhotoGridCell.m
//  Flickr Fetchr
//
//  Created by Tejas Ranade on 5/6/15.
//  Copyright (c) 2015 Tejas Ranade. All rights reserved.
//

#import "PhotoGridCell.h"
#import "FlickrPhoto.h"

@implementation PhotoGridCell

- (void) loadImage {
    if(self.photo){
        self.loadingSpinner.hidesWhenStopped = YES;
        [self.loadingSpinner startAnimating];

        NSOperationQueue* imageLoadingQueue = [[NSOperationQueue alloc] init];
        [imageLoadingQueue addOperationWithBlock:^{
            NSData* data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.photo.media]];
            if(!data) return;
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.loadingSpinner stopAnimating];
                self.photoView.image = [UIImage imageWithData:data];
            }];
        }];
    }
    //else load a default image
}
@end
