//
//  LSImageCollectionViewCell.m
//  ImagePicker
//
//  Created by noci on 16/6/1.
//  Copyright © 2016年 noci. All rights reserved.
//

#import "LSImageCollectionViewCell.h"

@implementation LSImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imageView];
        self.clipsToBounds = YES;
        
        _removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_removeButton setImage:[UIImage imageNamed:@"jiudian_icon_close_gray2"] forState:UIControlStateNormal];
        [_removeButton addTarget:self action:@selector(removeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_removeButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    
    CGSize size = _removeButton.imageView.image.size;
    
    _removeButton.frame = CGRectMake(self.bounds.size.width - size.width, 0, size.width, size.height);
    
}

-(void)setIsHiddenRemoveButton:(BOOL)isHiddenRemoveButton
{
    _removeButton.hidden = isHiddenRemoveButton;
}


-(void)removeAction
{
    if (self.didClickTheRemoveButton) {
        
        self.didClickTheRemoveButton(YES);
    }
}

@end
