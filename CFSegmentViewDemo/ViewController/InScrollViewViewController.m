//
//  InScrollViewViewController.m
//  CFSegmentViewDemo
//
//  Created by  chenfei on 2016/12/26.
//  Copyright © 2016年 chenfei. All rights reserved.
//

#import "InScrollViewViewController.h"

#import "UIViewController+BaseExtension.h"

#import "CFSegumentView.h"

#import "ViewController_Son1.h"
#import "ViewController_Son2.h"
//#import "ViewController_Son3.h"
#import "ViewController_Son5.h"

#import "BaseScrollView.h"


@interface InScrollViewViewController ()

@property(nonatomic,strong)BaseScrollView *scrollView;

@property(nonatomic,strong)CFSegumentView *segumentView;

@end

@implementation InScrollViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //常规设置
    self.navigationItem.title = @"ScrollView中";
    [self setNavBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置滚动视图
    [self setupScrollView];
    
}


-(void)setupScrollView{
    self.scrollView = [[BaseScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreenFullWidth, ScreenFullHeight-64)];
    _scrollView.contentSize = CGSizeMake(ScreenFullWidth, ScreenFullHeight+250-64);
    _scrollView.backgroundColor = [UIColor greenColor];
    
    self.segumentView = [[CFSegumentView alloc]initWithFrame:CGRectMake(0, 250, ScreenFullWidth, ScreenFullHeight-64)];
    _segumentView.showTittleScrollIndicator=YES;
    //    self.segmentView.scrollThenRefreshing = YES;
    _segumentView.tittles=@[@"第一",@"第二",@"第三"];
    _segumentView.tableClasses=@[[ViewController_Son5 class],[ViewController_Son2 class],[ViewController_Son5 class]];
    
    [_scrollView addSubview:_segumentView];
    
    [self.view addSubview:_scrollView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    NSLog(@"接触了控制器");
}




@end
