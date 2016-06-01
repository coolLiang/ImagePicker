//
//  LSImagePicker.h
//  ImagePicker
//
//  Created by noci on 16/6/1.
//  Copyright © 2016年 noci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSImagePicker : UIView

-(instancetype)initWithDelegate:(UIViewController *)vc andTheMaxNumberChooseImage:(int)number;

@property(nonatomic,copy)void(^didTheImageArrayHasChange)(NSArray<UIImage *> *photos);


@end
