//
//  TittleViewController.m
//  CFSegmentViewDemo
//
//  Created by  chenfei on 2016/12/23.
//  Copyright © 2016年 chenfei. All rights reserved.
//

#import "TittleViewController.h"

#import "UIViewController+BaseExtension.h"

#import "CFSegumentView.h"

#import "ViewController_Son1.h"
#import "ViewController_Son2.h"
#import "ViewController_Son3.h"


#define kWidth [UIScreen mainScreen].bounds.size.width

@interface TittleViewController ()

@property(nonatomic,strong)CFSegumentView *segmentView;

@end

@implementation TittleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.segmentView = [[CFSegumentView alloc]initWithFrame:CGRectMake(0, 64, ScreenFullWidth, ScreenFullHeight-64)];
//        self.segmentView.selfViewController=self;
    self.segmentView.showTittleScrollIndicator=YES;
    self.segmentView.scrollThenRefreshing = YES;
    self.segmentView.showTittle = NO;
    self.segmentView.tittles=@[@"第一",@"第二",@"第三"];
    self.segmentView.tableClasses=@[[ViewController_Son1 class],[ViewController_Son2 class],[ViewController_Son3 class]];
    
    __weak typeof(UIView *) view = self.segmentView.tittleView;
    
    self.navigationItem.titleView= view;
    
    [self.view addSubview:_segmentView];
    
}

@end
