//
//  ImageChooseManage.h
//  ImagePicker
//
//  Created by noci on 16/7/14.
//  Copyright © 2016年 noci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^onTheChoosedImageArrayUpdate)(NSArray * images);

@interface ImageChooseManage : NSObject

+(instancetype)shareImageChooseManage;

-(void)startChooseImageWithTheNumberMax:(int)number andChoosedImageArray:(NSArray *)choosedImages;

-(void)onTheChoosedImageArrayUpdate:(onTheChoosedImageArrayUpdate)block;

@end
