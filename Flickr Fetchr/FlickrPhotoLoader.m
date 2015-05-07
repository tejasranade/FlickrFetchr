//
//  FlickrPhotoLoader.m
//  Flickr Fetchr
//
//  Created by Tejas Ranade on 5/6/15.
//  Copyright (c) 2015 Tejas Ranade. All rights reserved.
//

#import "FlickrPhotoLoader.h"
#import "FlickrPhoto.h"
#import <AFNetworking/AFNetworking.h>

@interface FlickrPhotoLoader ()
@property (nonatomic, strong) AFHTTPRequestOperation* requestOperation;
@end

@implementation FlickrPhotoLoader

static const NSString* baseUrl = @"https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=?";

- (void) load {
    NSString* urlString = [NSString stringWithFormat:@"%@&tags=%@", baseUrl, self.searchTerm];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];

    AFHTTPRequestOperation* op = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSError* error = nil;
        NSData* resultData = (NSData*) responseObject;
        
        //hack to solve a flickr JSON abnormality
        NSString* resultStr = [NSString stringWithUTF8String:[resultData bytes]];
        resultStr = [resultStr stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"];
        
        NSDictionary* result = [NSJSONSerialization JSONObjectWithData:[resultStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        
        if (error) {
            [self.delegate onFailure: error];
        }
        else {
            NSArray* photosArrayObject = result[@"items"];
            NSMutableArray* photos = [[NSMutableArray alloc] init];
            for (NSDictionary* photoObject in photosArrayObject) {
                FlickrPhoto* photo = [[FlickrPhoto alloc] initWithJson: photoObject];
                [photos addObject:photo];
            }
            [self.delegate onSuccess: photos];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate onFailure: error];
    }];
    
    self.requestOperation = op;
    [self.requestOperation start];

}

- (BOOL) isLoading {
    return [self.requestOperation isExecuting];
}

- (void) cancel {

    if(self.requestOperation){
        [self.requestOperation cancel];
    }
}

@end
