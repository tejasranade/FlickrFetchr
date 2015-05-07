//
//  FlickrPhotoLoader.h
//  Flickr Fetchr
//
//  Created by Tejas Ranade on 5/6/15.
//  Copyright (c) 2015 Tejas Ranade. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FlickrPhotoLoaderDelegate <NSObject>
- (void) onSuccess: (NSArray*) photos;
- (void) onFailure: (NSError*) error;
@end

@interface FlickrPhotoLoader : NSObject
- (void) load;
- (void) cancel;
- (BOOL) isLoading;

@property (nonatomic, strong) NSString* searchTerm;
@property (nonatomic, weak) id<FlickrPhotoLoaderDelegate> delegate;
@end
