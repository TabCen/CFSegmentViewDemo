//
//  NormalViewController.m
//  CFSegmentViewDemo
//
//  Created by  chenfei on 2016/11/7.
//  Copyright © 2016年 chenfei. All rights reserved.
//

#import "NormalViewController.h"

#import "UIViewController+BaseExtension.h"

#import "CFSegumentView.h"

#import "ViewController_Son1.h"
#import "ViewController_Son2.h"
#import "ViewController_Son3.h"

@interface NormalViewController ()

@property(nonatomic,strong)CFSegumentView *segmentView;

@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self setNavBar];
    
    self.segmentView = [[CFSegumentView alloc]initWithFrame:CGRectMake(0, 64, ScreenFullWidth, ScreenFullHeight-64)];
//    self.segmentView.selfViewController=self;
    self.segmentView.showTittleScrollIndicator=YES;
    self.segmentView.tittles=@[@"第一",@"第二",@"第三"];
    self.segmentView.tableClasses=@[[ViewController_Son1 class],[ViewController_Son2 class],[ViewController_Son3 class]];
    [self.view addSubview:_segmentView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
