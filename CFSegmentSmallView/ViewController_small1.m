//
//  ViewController_small1.m
//  CFSegmentViewDemo
//
//  Created by  chenfei on 2017/5/9.
//  Copyright © 2017年 chenfei. All rights reserved.
//

#import "ViewController_small1.h"

@interface ViewController_small1 ()

@end

@implementation ViewController_small1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenFullWidth, 90)];
    
    
    view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
