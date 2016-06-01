//
//  ViewController.m
//  ImagePicker
//
//  Created by noci on 16/6/1.
//  Copyright © 2016年 noci. All rights reserved.
//

#import "ViewController.h"

#import "LSImagePicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LSImagePicker * lsImagePicker = [[LSImagePicker alloc]initWithDelegate:self andTheMaxNumberChooseImage:3];
    lsImagePicker.frame = CGRectMake(0, 20, 320, 400);
    [self.view addSubview:lsImagePicker];
    
    __weak typeof(self) weakSelf = self;
    
    [lsImagePicker setDidTheImageArrayHasChange:^(NSArray<UIImage *> *photos) {
       
        NSLog(@"photos = %@",photos);
        
    }];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
