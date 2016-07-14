//
//  ImageChooseManage.m
//  ImagePicker
//
//  Created by noci on 16/7/14.
//  Copyright © 2016年 noci. All rights reserved.
//

#import "ImageChooseManage.h"

#import "AlbumNavigationController.h"

#import "Tools.h"

@interface ImageChooseManage()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,copy)onTheChoosedImageArrayUpdate block;

@property(nonatomic,weak)UIViewController * currentVC;

@property(nonatomic,strong)NSMutableArray * images;

@property(nonatomic,assign)int imagesMax;

@end

@implementation ImageChooseManage

+(instancetype)shareImageChooseManage
{
    static ImageChooseManage * sharedImageChooseManage = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        sharedImageChooseManage = [[self alloc] init];
        sharedImageChooseManage.images = [NSMutableArray new];
        
    });
    
    return sharedImageChooseManage;
}

-(void)startChooseImageWithTheNumberMax:(int)number andChoosedImageArray:(NSArray *)choosedImages;
{
  
    self.images = [NSMutableArray arrayWithArray:choosedImages];
    self.imagesMax = number;
    
        self.currentVC = [Tools getCurrentViewController];
    
        UIImagePickerController * pickerVC = [[UIImagePickerController alloc]init];
        
        pickerVC.delegate = self;
        
        pickerVC.editing = YES;
        pickerVC.allowsEditing = YES;
        
        
        UIAlertController * actionSheet = [UIAlertController alertControllerWithTitle:@"请选择图片上传方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction * photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
            
            [self pickPhotoButtonClick:nil];
        }];
        
        UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //判断是否有相机
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self.currentVC presentViewController:pickerVC animated:YES completion:NULL];
                
            }
            else
            {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"相机功能未开启" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.currentVC dismissViewControllerAnimated:YES completion:nil];
                }];
                
                [alert addAction:action];
                [self.currentVC presentViewController:alert animated:YES completion:nil];
            }
        }];
        
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [self.currentVC dismissViewControllerAnimated:YES completion:NULL];
            
        }];
        
        [actionSheet addAction:photoAction];
        [actionSheet addAction:cameraAction];
        [actionSheet addAction:cancel];
        [self.currentVC  presentViewController:actionSheet animated:YES completion:NULL];
    
}

- (void)pickPhotoButtonClick:(UIButton *)sender {
    
    AlbumNavigationController *navigation = [[AlbumNavigationController alloc] initWithMaxImagesCount:self.imagesMax delegate:nil];
    navigation.allowPickingVideo = NO;
    
    navigation.currentImagesCount = self.images.count;
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    
    __weak typeof(self) weakSelf = self;
    
    [navigation setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
        
        [weakSelf.images addObjectsFromArray:photos];
        if (weakSelf.block) {
            
            weakSelf.block(weakSelf.images);
            
        }
        
    }];
    
    [[Tools getCurrentViewController] presentViewController:navigation animated:YES completion:nil];
}

//选完的image/
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.images addObject:image];
    
    if (self.block) {
        
        self.block(self.images);
        
    }
    
    [self.currentVC dismissViewControllerAnimated:YES completion:nil];
}

-(void)onTheChoosedImageArrayUpdate:(onTheChoosedImageArrayUpdate)block
{
    self.block = block;
}

@end
