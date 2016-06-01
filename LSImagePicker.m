//
//  LSImagePicker.m
//  ImagePicker
//
//  Created by noci on 16/6/1.
//  Copyright © 2016年 noci. All rights reserved.
//

#import "LSImagePicker.h"
#import "LSImageCollectionViewCell.h"

#import "AlbumNavigationController.h"

@interface LSImagePicker()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView * imageCollection;

@property(nonatomic,weak)UIViewController * superVC;

@property(nonatomic,assign)int theMaxNumberChooseImage;

@property(nonatomic,strong)NSMutableArray * photos;

@end

@implementation LSImagePicker

-(instancetype)initWithDelegate:(UIViewController *)vc andTheMaxNumberChooseImage:(int)number;
{
    self = [super init];
    
    if (self) {
        
        self.superVC = vc;
        self.theMaxNumberChooseImage = 3;
        self.photos = [NSMutableArray new];
        [self buildUI];
        [self buildCS];
        [self buildMVVM];
    }
    
    return self;
}

-(void)buildUI
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.imageCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 320, 400) collectionViewLayout:layout];
    self.imageCollection.delegate = self;
    self.imageCollection.dataSource = self;
    
    self.imageCollection.backgroundColor = [UIColor lightGrayColor];
    
    
    // Register cell classes
    [self.imageCollection registerClass:[LSImageCollectionViewCell class] forCellWithReuseIdentifier:@"LSImageCollectionViewCell"];
    [self addSubview:self.imageCollection];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (self.photos.count > 0 && self.photos.count < self.theMaxNumberChooseImage) {
        
        return self.photos.count + 1;
    }
    else if (self.photos.count == self.theMaxNumberChooseImage)
        
    {
        return self.photos.count;
    }
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    LSImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LSImageCollectionViewCell" forIndexPath:indexPath];
    
    if (indexPath.row == self.photos.count) {
        
        cell.imageView.image = [UIImage imageNamed:@"MY_pic_pic"];
        cell.isHiddenRemoveButton = YES;
        
    } else {
        
        cell.imageView.image = self.photos[indexPath.row];
        cell.isHiddenRemoveButton = NO;
    }
    
    
    cell.didClickTheRemoveButton = ^(BOOL isremove)
    {
        [self.photos removeObjectAtIndex:indexPath.row];
        
        if (self.didTheImageArrayHasChange) {
            
            self.didTheImageArrayHasChange(self.photos);
        }

        [collectionView reloadData];
    };
    
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(100,100);
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.photos.count) [self pickPhotoButtonClick:nil];
}

#pragma mark Click Event
- (void)pickPhotoButtonClick:(UIButton *)sender {
    
    AlbumNavigationController *navigation = [[AlbumNavigationController alloc] initWithMaxImagesCount:self.theMaxNumberChooseImage delegate:nil];
    navigation.allowPickingVideo = NO;
    
    navigation.currentImagesCount = self.photos.count;
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    
    __weak typeof(self) weakSelf = self;
    
    [navigation setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
        
        [weakSelf.photos addObjectsFromArray:photos];
        if (weakSelf.didTheImageArrayHasChange) {
            
            weakSelf.didTheImageArrayHasChange(weakSelf.photos);
        }
        
        [weakSelf.imageCollection reloadData];
        
    }];
    
    [self.superVC presentViewController:navigation animated:YES completion:nil];
    
}

-(void)buildCS
{
    
}

-(void)buildMVVM
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
