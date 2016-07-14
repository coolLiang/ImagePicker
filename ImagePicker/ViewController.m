//
//  ViewController.m
//  ImagePicker
//
//  Created by noci on 16/6/1.
//  Copyright © 2016年 noci. All rights reserved.
//

#import "ViewController.h"

#import "ImageChooseManage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[ImageChooseManage shareImageChooseManage] startChooseImageWithTheNumberMax:3 andChoosedImageArray:nil];
    
    
    [[ImageChooseManage shareImageChooseManage]onTheChoosedImageArrayUpdate:^(NSArray *images) {
        
        NSLog(@"%@",images);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
