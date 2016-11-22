//
//  WithRefreshViewController.m
//  CFSegmentViewDemo
//
//  Created by  chenfei on 2016/11/8.
//  Copyright © 2016年 chenfei. All rights reserved.
//

#import "WithRefreshViewController.h"
#import "UIViewController+BaseExtension.h"
#import "ViewController_Son3.h"
#import "ViewController_Son2.h"
#import "CFSegumentView.h"


@interface WithRefreshViewController ()<CFSegumentViewDelegate>
@property(nonatomic,strong)CFSegumentView *segument;

@end

@implementation WithRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self setNavBar];
    
    [self setReFreshBtn];
    //
    self.segument=[[CFSegumentView alloc]initWithFrame:CGRectMake(0, 64, ScreenFullWidth, ScreenFullHeight-64)];
    
    _segument.tittles=@[@"第一",@"第二",@"第三"];
    
    _segument.tableClasses=@[[ViewController_Son3 class],[ViewController_Son2 class],[ViewController_Son3 class]];
    
    _segument.delegate=self;
    
    [self.view addSubview:_segument];
}

-(void)tableRefresh{
    [self.segument tableViewRefresh];
}

-(void)setReFreshBtn{
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"refresh"] style:UIBarButtonItemStylePlain target:self action:@selector(tableRefresh)];
    [button setTintColor:[UIColor redColor]];
    
    self.navigationItem.rightBarButtonItem=button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)CFSegumentView:(CFSegumentView *)segumetView currentViewController:(UITableViewController *)tableVC{

    ViewController_Son3 *tabVC=(ViewController_Son3 *)tableVC;

    [tabVC.tableView.mj_header beginRefreshing];
    
}

@end
