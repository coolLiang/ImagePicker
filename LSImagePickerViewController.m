//
//  LSImagePickerViewController.m
//  ImagePicker
//
//  Created by noci on 16/6/1.
//  Copyright © 2016年 noci. All rights reserved.
//

#import "LSImagePickerViewController.h"
#import "LSImageCollectionViewCell.h"

#import "AlbumNavigationController.h"

@interface LSImagePickerViewController ()

@end

@implementation LSImagePickerViewController

static NSString * const reuseIdentifier = @"LSImageCollectionViewCell";

- (instancetype)init
{
    //创建流水布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //    // 设置cell之间间距
    layout.minimumInteritemSpacing = 0;
    //    // 设置行距
    layout.minimumLineSpacing = 0;
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[LSImageCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (self.imageArray.count > 0) {
        
        return self.imageArray.count;
    }
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    LSImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (indexPath.row == self.imageArray.count) {
        
        cell.imageView.image = [UIImage imageNamed:@"MY_pic_pic"];
        
    } else {
        
        cell.imageView.image = self.imageArray[indexPath.row];
    }
    
    
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(100,100);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.imageArray.count) [self pickPhotoButtonClick:nil];
}

#pragma mark Click Event
- (void)pickPhotoButtonClick:(UIButton *)sender {
    
    AlbumNavigationController *navigation = [[AlbumNavigationController alloc] initWithMaxImagesCount:9 delegate:nil];
    navigation.allowPickingVideo = NO;
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    
    [navigation setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
        
        
        NSLog(@"photos = %@",photos);
        NSLog(@"assets = %@",assets);
        
    }];
    
    [self presentViewController:navigation animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
