//
//  HomeSelectViewController.m
//  CFSegmentViewDemo
//
//  Created by  chenfei on 2017/5/9.
//  Copyright © 2017年 chenfei. All rights reserved.
//

#import "HomeSelectViewController.h"
#import "UIViewController+BaseExtension.h"

#import "CFSegumentSmallView.h"

#import "ViewController_small1.h"

#import "ViewController_small2.h"

@interface HomeSelectViewController ()

@property(nonatomic,strong)CFSegumentSmallView *segmentSmallView;

@end

@implementation HomeSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    [self setNavBar];
    
    self.navigationItem.title = @"房产选择控件";
    
    self.segmentSmallView = [[CFSegumentSmallView alloc]initWithFrame:CGRectMake(0, 64, ScreenFullWidth, 50)];
    
    _segmentSmallView.tittles=@[@"第一",@"第二",@"第三"];
    
    _segmentSmallView.subVCs=@[[ViewController_small1 class],[ViewController_small2 class],[ViewController_small2 class]];
    
    [self.view addSubview:_segmentSmallView];
    
}




@end
