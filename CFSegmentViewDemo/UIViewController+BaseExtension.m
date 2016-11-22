//
//  UIViewController+BaseExtension.m
//  CFSegmentViewDemo
//
//  Created by  chenfei on 2016/11/8.
//  Copyright © 2016年 chenfei. All rights reserved.
//

#import "UIViewController+BaseExtension.h"

@implementation UIViewController (BaseExtension)


-(void)setNavBar{
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 10, 18)];
    [backBtn setImage:[UIImage imageNamed:@"cancel-left"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
