//
//  FlickrPhoto.m
//  Flickr Fetchr
//
//  Created by Tejas Ranade on 5/6/15.
//  Copyright (c) 2015 Tejas Ranade. All rights reserved.
//

#import "FlickrPhoto.h"

@implementation FlickrPhoto
- (id) initWithJson: (NSDictionary*) json {
    if (self = [super init]){
        _title = json[@"title"];
        _media = json[@"media"][@"m"];
    }
    return self;
}
@end
