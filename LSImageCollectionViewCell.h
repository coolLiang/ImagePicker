//
//  LSImageCollectionViewCell.h
//  ImagePicker
//
//  Created by noci on 16/6/1.
//  Copyright © 2016年 noci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic,assign)BOOL isHiddenRemoveButton;

@property (nonatomic, strong) UIButton * removeButton;

@property (nonatomic,copy)void (^didClickTheRemoveButton)(BOOL);


@end
