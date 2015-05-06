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
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.photo.media]];
            if ( data == nil )
                return;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.photoView.image = [UIImage imageWithData:data];
            });
        });
    }
    //else load a default image
}
@end
