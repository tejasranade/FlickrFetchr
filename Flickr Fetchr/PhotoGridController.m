//
//  ViewController.m
//  Flickr Fetchr
//
//  Created by Tejas Ranade on 5/6/15.
//  Copyright (c) 2015 Tejas Ranade. All rights reserved.
//

#import "PhotoGridController.h"
#import "PhotoGridCell.h"

#define MARGIN_BETWEEN_IMAGES 3.0
#define IMAGES_PER_ROW 3

@interface PhotoGridController ()
@property (nonatomic, weak) IBOutlet UICollectionView* collectionView;
@property (nonatomic, strong) NSMutableArray* photos;
@property (nonatomic, strong) FlickrPhotoLoader* service;
- (void) loadPhotosForSearchKey: (NSString*) searchKey;
@end

@implementation PhotoGridController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPhotosForSearchKey:@""];
}

- (void) loadPhotosForSearchKey: (NSString*) searchKey {
    if(!_service){
        _service = [[FlickrPhotoLoader alloc] init];
    }
    
    if ([self.service isLoading]){
        [self.service cancel];
    }
    
    self.service.searchTerm = searchKey;
    self.service.delegate = self;
    [self.service load];
}

#pragma Photo loader delegate
- (void) onSuccess: (NSArray*) newPhotos {
    self.photos = [NSMutableArray arrayWithArray:newPhotos];
    [self.collectionView reloadData];
}

- (void) onFailure: (NSError*) error {
    NSLog(@"%@", error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma CollectionView datasource methods
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath { PhotoGridCell *cell = (PhotoGridCell*)[cv dequeueReusableCellWithReuseIdentifier:@"FlickrImageCell"
                                                                                                                                                                                      forIndexPath:indexPath];
    cell.photo = [self.photos objectAtIndex:indexPath.row];
    [cell loadImage];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    //Do nothing for now. Possibly go to a large image view later
}

#pragma CollectionView layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat imageSize = (self.view.frame.size.width- 3*IMAGES_PER_ROW*MARGIN_BETWEEN_IMAGES)/IMAGES_PER_ROW;
    return CGSizeMake(imageSize, imageSize);
}

- (UIEdgeInsets)collectionView: (UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(10, MARGIN_BETWEEN_IMAGES, 10, MARGIN_BETWEEN_IMAGES);
}

#pragma SearchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    [searchBar resignFirstResponder];
    [self loadPhotosForSearchKey:searchBar.text];

}

@end
