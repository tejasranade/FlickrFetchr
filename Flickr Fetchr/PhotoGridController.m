//
//  ViewController.m
//  Flickr Fetchr
//
//  Created by Tejas Ranade on 5/6/15.
//  Copyright (c) 2015 Tejas Ranade. All rights reserved.
//

#import "PhotoGridController.h"
#import "PhotoGridCell.h"

@interface PhotoGridController ()
@property (nonatomic, weak) IBOutlet UICollectionView* collectionView;
@property (nonatomic, strong) NSMutableArray* photos;
@end

@implementation PhotoGridController

- (void)viewDidLoad {
    [super viewDidLoad];

    FlickrPhotoLoader* service = [[FlickrPhotoLoader alloc] init];
    service.searchTerm = @"";
    service.delegate = self;
    [service load];
}

#pragma Photo loader delegate
- (void) onSuccess: (NSArray*) newPhotos {
    self.photos = [NSMutableArray arrayWithArray:newPhotos];
    [self.collectionView reloadData];
}

- (void) onFailure: (NSError*) error {

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

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath { PhotoGridCell *cell = (PhotoGridCell*)[cv dequeueReusableCellWithReuseIdentifier:@"FlickrImageCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.photo = [self.photos objectAtIndex:indexPath.row];
    [cell loadImage];
    //UIImageView* imageView = cell.photoView;
    //imageView.image = [UIImage imageW:[self.photos objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    //do nothing for now
}

#pragma CollectionView layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(100, 100);
}

- (UIEdgeInsets)collectionView: (UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(50, 20, 50, 20);
}

#pragma SearchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    FlickrPhotoLoader* service = [[FlickrPhotoLoader alloc] init];
    service.searchTerm = searchBar.text;
    service.delegate = self;
    [service load];

}

@end
